Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965229AbeE2Qi2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 12:38:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935569AbeE2QiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 12:38:25 -0400
X-Google-Smtp-Source: AB8JxZqzHZTbQEq45az1A7RyQP2V/YJK2Rc5cfyFyr2k9YExRirGA8A0QbgDAuh0W6eMTrs88pJ8c+VZqAgatMsgB1o=
MIME-Version: 1.0
In-Reply-To: <20180529150455.17300-4-peron.clem@gmail.com>
References: <20180529150455.17300-1-peron.clem@gmail.com> <20180529150455.17300-4-peron.clem@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 29 May 2018 11:38:02 -0500
X-Gmail-Original-Message-ID: <CABGGisywxqoFjhp6uOwZ-TG-Dv4dKLtZMnq90EcccurAvuwcVg@mail.gmail.com>
Message-ID: <CABGGisywxqoFjhp6uOwZ-TG-Dv4dKLtZMnq90EcccurAvuwcVg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] Documentation: DT: add i.MX EPIT timer binding
To: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Colin Didier <colin.didier@devialet.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?Q?Cl=C3=A9ment_Peron?= <clement.peron@devialet.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4TGcrOF005179

On Tue, May 29, 2018 at 10:04 AM, Clément Péron <peron.clem@gmail.com> wrote:
> From: Clément Peron <clement.peron@devialet.com>
>
> Add devicetree binding document for NXP's i.MX SoC specific
> EPIT timer driver.
>
> Signed-off-by: Clément Peron <clement.peron@devialet.com>
> ---
>  .../devicetree/bindings/clock/imx6q,epit.txt  | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx6q,epit.txt

Please send DT bindings to the correct list.

Rob
