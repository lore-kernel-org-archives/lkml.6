Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755417AbeCSJDS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 05:03:18 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54043 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932857AbeCSJC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 05:02:27 -0400
Message-ID: <1521450140.5471.1.camel@pengutronix.de>
Subject: Re: [PATCH v3 1/2] dt-bindings: reset: add STM32MP1 resets
From: Philipp Zabel <p.zabel@pengutronix.de>
To: gabriel.fernandez@st.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, gabriel.fernandez.st@gmail.com,
        Loic PALLARDY <loic.pallardy@st.com>,
        benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org
Date: Mon, 19 Mar 2018 10:02:20 +0100
In-Reply-To: <1521444351-29550-2-git-send-email-gabriel.fernandez@st.com>
References: <1521444351-29550-1-git-send-email-gabriel.fernandez@st.com>
         <1521444351-29550-2-git-send-email-gabriel.fernandez@st.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriel,

On Mon, 2018-03-19 at 08:25 +0100, gabriel.fernandez@st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch adds the reset binding entry for STM32MP1
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

thank you, both applied to reset/next.

regards
Philipp
