Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751832AbeEWE36 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 00:29:58 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37115 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbeEWE34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 00:29:56 -0400
X-Google-Smtp-Source: AB8JxZoTPSb3VdCDLxLwRrQVWJrmwjRAY97HBzRqrIlr7nOykqxekdnBnS8WhKWdFHq/HDyNqb97pQ==
Date: Wed, 23 May 2018 09:59:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: =?utf-8?Q?S=C3=A9bastien?= Szymanski
        <sebastien.szymanski@armadeus.com>
Cc: linux-arm-kernel@lists.infradead.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] cpufreq: imx6q: check speed grades for i.MX6ULL
Message-ID: <20180523042953.kcp2h5xtwjrjponn@vireshk-i7>
References: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-05-18, 08:28, Sébastien Szymanski wrote:
> Check the max speed supported from the fuses for i.MX6ULL and update the
> operating points table accordingly.
> 
> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> ---
> 
> Changes for v3:
>  - none

@Sascha and Shawn: Can you guys please Ack this series if there is
nothing wrong with it ?

-- 
viresh
