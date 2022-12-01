// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

// swiftlint:disable all
public final class EvolutionQuery: GraphQLQuery {
  // The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query evolution($id: String!) {
      evolutionChain(id: $id) {
        __typename
        response
      }
    }
    """

  public let operationName: String = "evolution"

  public var id: String

  public init(id: String) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("evolutionChain", arguments: ["id": GraphQLVariable("id")], type: .object(EvolutionChain.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(evolutionChain: EvolutionChain? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "evolutionChain": evolutionChain.flatMap { (value: EvolutionChain) -> ResultMap in value.resultMap }])
    }

    public var evolutionChain: EvolutionChain? {
      get {
        return (resultMap["evolutionChain"] as? ResultMap).flatMap { EvolutionChain(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "evolutionChain")
      }
    }

    public struct EvolutionChain: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["BaseResponse"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("response", type: .scalar(JSON.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(response: JSON? = nil) {
        self.init(unsafeResultMap: ["__typename": "BaseResponse", "response": response])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var response: JSON? {
        get {
          return resultMap["response"] as? JSON
        }
        set {
          resultMap.updateValue(newValue, forKey: "response")
        }
      }
    }
  }
}

public typealias JSON = [String : Any?]

extension Dictionary: JSONDecodable {
  // Custom `init` extension so Apollo can decode custom scalar type `CurrentMissionChallenge `
  public init(jsonValue value: JSONValue) throws {
    guard let dictionary = value as? Dictionary else {
      throw JSONDecodingError.couldNotConvert(value: value, to: Dictionary.self)
    }
    self = dictionary
  }
}
