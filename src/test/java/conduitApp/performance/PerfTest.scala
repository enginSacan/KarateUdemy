package performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._
import conduitApp.performance.createTokens.CreateTokens


class PerfTest extends Simulation {

  CreateTokens.createAccessTokens()
  val protocol = karateProtocol(
    "/api/articles/{articleId}" -> Nil
  )

  protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")
  protocol.runner.karateEnv("perf")
  val tokenFeeder = Iterator.continually {
    Map("token" -> CreateTokens.getNextToken)
  } 
  //val createArticle = scenario("create and delete article").exec(karateFeature("classpath:conduitApp/performance/createArticle.feature"))
  //val delete = scenario("delete").exec(karateFeature("classpath:mock/cats-delete.feature@name=delete"))
  val createArticle = scenario("create and delete article").feed(tokenFeeder).feed(csv("articles.csv").circular())exec(karateFeature("classpath:conduitApp/performance/createArticle.feature"))
  setUp(
    createArticle.inject(
      atOnceUsers(10),
      nothingFor(4),
      constantUsersPerSec(1).during(10),
      rampUsersPerSec(1).to(10).during(20 seconds)).protocols(protocol),
    //delete.inject(rampUsers(5) during (5 seconds)).protocols(protocol)
  )

}