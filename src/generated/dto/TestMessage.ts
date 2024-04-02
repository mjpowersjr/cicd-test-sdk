/* eslint-disable */
import * as _m0 from "protobufjs/minimal";

export interface TestMessage {
  fieldOne: string;
}

function createBaseTestMessage(): TestMessage {
  return { fieldOne: "" };
}

export const TestMessage = {
  encode(message: TestMessage, writer: _m0.Writer = _m0.Writer.create()): _m0.Writer {
    if (message.fieldOne !== "") {
      writer.uint32(10).string(message.fieldOne);
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
      }
      if ((tag & 7) === 4 || tag === 0) {
        break;
      }
      reader.skipType(tag & 7);
    }
    return message;
  },

  fromJSON(object: any): TestMessage {
    return { fieldOne: isSet(object.fieldOne) ? globalThis.String(object.fieldOne) : "" };
  },

  toJSON(message: TestMessage): unknown {
    const obj: any = {};
    if (message.fieldOne !== "") {
      obj.fieldOne = message.fieldOne;
    }
    return obj;
  },

  create<I extends Exact<DeepPartial<TestMessage>, I>>(base?: I): TestMessage {
    return TestMessage.fromPartial(base ?? ({} as any));
  },
  fromPartial<I extends Exact<DeepPartial<TestMessage>, I>>(object: I): TestMessage {
    const message = createBaseTestMessage();
    message.fieldOne = object.fieldOne ?? "";
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
