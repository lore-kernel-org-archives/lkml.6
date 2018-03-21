Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751753AbeCUCTK convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:19:10 -0400
Received: from hermes.aosc.io ([199.195.250.187]:51892 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751456AbeCUCTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:19:08 -0400
Date: Wed, 21 Mar 2018 10:18:13 +0800
In-Reply-To: <20180320184646.dynqv6qubzabroe4@flea>
References: <20180316175354.21437-1-icenowy@aosc.io> <20180316175354.21437-3-icenowy@aosc.io> <20180320184646.dynqv6qubzabroe4@flea>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 2/7] dt-bindings: add binding for the Allwinner A64 DE2 bus
To: Maxime Ripard <maxime.ripard@bootlin.com>
CC: Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
From: Icenowy Zheng <icenowy@aosc.io>
Message-ID: <AAC74653-C6EB-4BE3-BB19-210687C1E158@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年3月21日 GMT+08:00 上午2:46:46, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>On Sat, Mar 17, 2018 at 01:53:49AM +0800, Icenowy Zheng wrote:
>> All the sub-blocks of Allwinner A64 DE2 needs the SRAM C on A64 SoC
>to
>> be claimed, otherwise the whole DE2 space is inaccessible.
>> 
>> Add a device tree binding of the DE2 part as a sub-bus.
>
>Where did you get the info that it was a bus?

There's no direct evidence, just some guess.

The DE2 is a whole part that is just allocated a memory
space at the user manual, and the SRAM controls the
access to all modules in the DE2.

So it might be a bus.

Implement it as a bus is a clear representation on A64.

>
>Maxime
