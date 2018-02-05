Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753326AbeBERRY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 12:17:24 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33794 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752787AbeBERRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 12:17:14 -0500
X-Google-Smtp-Source: AH8x225mKWLEsi2tH/0bj+pmaze+sSGbeXiXZpTqH/Ge29bMD79o3pjEdRc8QXF6apeirCPMktMegbze2BlUrZ+QJWg=
MIME-Version: 1.0
In-Reply-To: <20180205170840.14045-1-sebastian.reichel@collabora.co.uk>
References: <20180205052659.GA31354@dragon> <20180205170840.14045-1-sebastian.reichel@collabora.co.uk>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 5 Feb 2018 15:17:13 -0200
Message-ID: <CAOMZO5DGXHxA5p5B-t64343628J2PwVqDAsMMNO5aDgpxdzsVg@mail.gmail.com>
Subject: Re: [PATCHv2] ARM: dts: imx6q-bx50v3: Enable secure-reg-access
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, Ian Ray <ian.ray@ge.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 3:08 PM, Sebastian Reichel
<sebastian.reichel@collabora.co.uk> wrote:
> From: Peter Senna Tschudin <peter.senna@collabora.com>
>
> Enable secure debug enable register access for Bx50v3 devices to enable
> PMU and hardware counters for perf.
>
> Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
