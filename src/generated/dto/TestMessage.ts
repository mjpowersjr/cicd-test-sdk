/* eslint-disable */
import * as _m0 from "protobufjs/minimal";

export interface TestMessage {
  fieldOne: string;
  /** add comment */
  fieldTwo: string;
  fieldThree: string;
}

function createBaseTestMessage(): TestMessage {
  return { fieldOne: "", fieldTwo: "", fieldThree: "" };
}

export const TestMessage = {
  encode(message: TestMessage, writer: _m0.Writer = _m0.Writer.create()): _m0.Writer {
    if (message.fieldOne !== "") {
      writer.uint32(10).string(message.fieldOne);
    }
    if (message.fieldTwo !== "") {
      writer.uint32(18).string(message.fieldTwo);
    }
    if (message.fieldThree !== "") {
      writer.uint32(26).string(message.fieldThree);
    }
    return writer;
  },

  decode(input: _m0.Reader | Uint8Array, length?: number): TestMessage {
    const reader = input instanceof _m0.Reader ? input : _m0.Reader.create(input);
    let end = length === undefined ? reader.len : reader.pos + length;
    const message = createBaseTestMessage();
    while (reader.pos < end) {
      const tag = reader.uint32();
      switch (tag >>> 3) {
        case 1:
          if (tag !== 10) {
            break;
          }

          message.fieldOne = reader.string();
          continue;
        case 2:
          if (tag !== 18) {
            break;
          }

          message.fieldTwo = reader.string();
          continue;
        case 3:
          if (tag !== 26) {
            break;
          }

          message.fieldThree = reader.string();
          continue;
      }
      if ((tag & 7) === 4 || tag === 0) {
        break;
      }
      reader.skipType(tag & 7);
    }
    return message;
  },

  fromJSON(object: any): TestMessage {
    return {
      fieldOne: isSet(object.fieldOne) ? globalThis.String(object.fieldOne) : "",
      fieldTwo: isSet(object.fieldTwo) ? globalThis.String(object.fieldTwo) : "",
      fieldThree: isSet(object.fieldThree) ? globalThis.String(object.fieldThree) : "",
    };
  },

  toJSON(message: TestMessage): unknown {
    const obj: any = {};
    if (message.fieldOne !== "") {
      obj.fieldOne = message.fieldOne;
    }
    if (message.fieldTwo !== "") {
      obj.fieldTwo = message.fieldTwo;
    }
    if (message.fieldThree !== "") {
      obj.fieldThree = message.fieldThree;
    }
    return obj;
  },

  create<I extends Exact<DeepPartial<TestMessage>, I>>(base?: I): TestMessage {
    return TestMessage.fromPartial(base ?? ({} as any));
  },
  fromPartial<I extends Exact<DeepPartial<TestMessage>, I>>(object: I): TestMessage {
    const message = createBaseTestMessage();
    message.fieldOne = object.fieldOne ?? "";
    message.fieldTwo = object.fieldTwo ?? "";
    message.fieldThree = object.fieldThree ?? "";
    return message;
  },
};

type Builtin = Date | Function | Uint8Array | string | number | boolean | bigint | undefined;

type DeepPartial<T> = T extends Builtin ? T
  : T extends globalThis.Array<infer U> ? globalThis.Array<DeepPartial<U>>
  : T extends ReadonlyArray<infer U> ? ReadonlyArray<DeepPartial<U>>
  : T extends {} ? { [K in keyof T]?: DeepPartial<T[K]> }
  : Partial<T>;

type KeysOfUnion<T> = T extends T ? keyof T : never;
type Exact<P, I extends P> = P extends Builtin ? P
  : P & { [K in keyof P]: Exact<P[K], I[K]> } & { [K in Exclude<keyof I, KeysOfUnion<P>>]: never };

function isSet(value: any): boolean {
  return value !== null && value !== undefined;
}
