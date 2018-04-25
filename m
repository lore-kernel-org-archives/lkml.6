Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754129AbeDYNqx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:46:53 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33225 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753825AbeDYNqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:46:49 -0400
X-Google-Smtp-Source: AIpwx48WEMxaJzesHqDMo1Q8O2wENnYinTe1wNo8n4C/wD+2t7Oj0bXcxJoMZhHE1GG2d3lYK2UpruK3TmKlqQVXKiw=
MIME-Version: 1.0
In-Reply-To: <AM3PR04MB1315B04BE46755E3EB82E04CF58F0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1524455219-6736-1-git-send-email-Anson.Huang@nxp.com>
 <1524455219-6736-4-git-send-email-Anson.Huang@nxp.com> <CAOMZO5CDAQtw7Q6NgSzKP4ogaqRaGSE0A+st1iqZ=cQsK49moQ@mail.gmail.com>
 <AM3PR04MB131566E1C8033D256686F192F5880@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5Dm=MFRoh=y54Qf2RrncWfQPTUJ2ZNfvYnUD=idp8RPNA@mail.gmail.com>
 <AM3PR04MB1315ED599A20F67BB9FEFEE1F58F0@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <AM3PR04MB1315B04BE46755E3EB82E04CF58F0@AM3PR04MB1315.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 25 Apr 2018 10:46:48 -0300
Message-ID: <CAOMZO5AS=aH8p1+tmgJ4ooeqExNqOALh7vbPAsQdqdky8CkXyQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] ARM: dts: imx6sx-sabreauto: add fec support
To: Anson Huang <anson.huang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Wed, Apr 25, 2018 at 2:36 AM, Anson Huang <anson.huang@nxp.com> wrote:

> Sorry, I made a mistake here, the MAX7320 IO0 is for adjusting FEC1's voltage,

In this case you need to pass the 'phy-supply' property inside the fec
node and add a regulator that is controlled via MAX7320 IO0 pin.
