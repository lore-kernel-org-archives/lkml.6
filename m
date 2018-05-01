Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755711AbeEAMug (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 08:50:36 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:43012 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755259AbeEAMue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 08:50:34 -0400
X-Google-Smtp-Source: AB8JxZr9S61ohHrt5A5a+xW9Rvua5dQ3ovOOGGMOeG0sV3yvnnLv/8NgvveqWIEeuIz7elbbH2mXdA==
Date: Tue, 1 May 2018 07:50:33 -0500
From: Rob Herring <robh@kernel.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Aleksander Morgado <aleksander@aleksander.es>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: nvmem: Add binding for RAVE SP
 EEPROM driver
Message-ID: <20180501125033.GA8090@rob-hp-laptop>
References: <20180501052952.26765-1-andrew.smirnov@gmail.com>
 <20180501052952.26765-2-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501052952.26765-2-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 10:29:51PM -0700, Andrey Smirnov wrote:
> Add Device Tree bindings for RAVE SP EEPROM driver - an MFD cell of
> parent RAVE SP driver (documented in
> Documentation/devicetree/bindings/mfd/zii,rave-sp.txt).
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Aleksander Morgado <aleksander@aleksander.es>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  .../bindings/nvmem/zii,rave-sp-eeprom.txt          | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt

Reviewed-by: Rob Herring <robh@kernel.org>
