import graphene


class Hello(graphene.ObjectType):
    hello = graphene.String()

    def resolve_hello(self, info):
        return "Hi!"


class Query(Hello, graphene.ObjectType):
    pass


schema = graphene.Schema(query=Hello)
