/***************************************************************************************************
 * <one line to give the library's name and a brief idea of what it does.>
 * Copyright (C) <year>  <name of author>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
 **************************************************************************************************/

// Interface: rbi_if
// RBI (Register Bus Interface) interface definition for register access.
// This interface defines signals which are used for simple reading and writing of registers in a
//  regsiter bank.
// The interface supports both read and write operations with acknowledgment and error signaling.
//
// Parameters:
//  ADDR_WIDTH - Width of the address bus (default: 32 bits)
//  DATA_WIDTH - Width of the data bus (default: 32 bits)
//
// Ports:
//  clk        - Clock signal for synchronization
//  rst_n      - Active low reset signal
//
// Interface Operation:
//
// TODO
interface rbi_if #(
    parameter int unsigned ADDR_WIDTH = 32,
    parameter int unsigned DATA_WIDTH = 32
) (
    input logic clk,
    input logic rst_n
);

    logic [ADDR_WIDTH-1:0] addr;

    logic                  write_en;
    logic                  write_ack;
    logic [DATA_WIDTH-1:0] wdata;
    logic [DATA_WIDTH-1:0] wbit_mask;
    logic                  write_err;

    logic                  read_en;
    logic                  read_ack;
    logic [DATA_WIDTH-1:0] rdata;
    logic                  read_err;

    logic                  ready;

    modport manager (
        input clk, rst_n,

        output addr,

        output write_en, wdata, wbit_mask,
        input write_ack, write_err,

        output read_en,
        input read_ack, rdata, read_err
    );

    modport subordinate (
        input clk, rst_n,

        input addr,

        input write_en, wdata, wbit_mask,
        output write_ack, write_err,

        input read_en,
        output read_ack, rdata, read_err
    );
endinterface : rbi_if
