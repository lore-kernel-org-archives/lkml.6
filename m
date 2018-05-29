Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935348AbeE2ObU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:31:20 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:55969 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934857AbeE2ObP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:31:15 -0400
From: Gevorg Sahakyan <Gevorg.Sahakyan@synopsys.com>
To: William Wu <william.wu@rock-chips.com>,
        "Minas.Harutyunyan@synopsys.com" <Minas.Harutyunyan@synopsys.com>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "sergei.shtylyov@cogentembedded.com"
        <sergei.shtylyov@cogentembedded.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org"
        <linux-rockchip@lists.infradead.org>,
        "frank.wang@rock-chips.com" <frank.wang@rock-chips.com>,
        "huangtao@rock-chips.com" <huangtao@rock-chips.com>,
        "dianders@google.com" <dianders@google.com>,
        "daniel.meng@rock-chips.com" <daniel.meng@rock-chips.com>,
        "John.Youn@synopsys.com" <John.Youn@synopsys.com>,
        "wzz@rock-chips.com" <wzz@rock-chips.com>,
        "zsq@rock-chips.com" <zsq@rock-chips.com>,
        "Allen.Hsu@quantatw.com" <Allen.Hsu@quantatw.com>,
        "StanTsui@AOPEN.com" <StanTsui@AOPEN.com>,
        "Spruce.Wu@quantatw.com" <Spruce.Wu@quantatw.com>,
        "Martin.Tsai@quantatw.com" <Martin.Tsai@quantatw.com>,
        "Kevin.Shai@quantatw.com" <Kevin.Shai@quantatw.com>,
        "Mon-Jer.Wu@quantatw.com" <Mon-Jer.Wu@quantatw.com>,
        "Claud.Chang@quantatw.com" <Claud.Chang@quantatw.com>,
        "San.Lin@quantatw.com" <San.Lin@quantatw.com>,
        "Ren.Kuo@quantatw.com" <Ren.Kuo@quantatw.com>,
        "davidhtwang@aopen.com" <davidhtwang@AOPEN.com>,
        "fonglin@aopen.com" <fonglin@AOPEN.com>,
        "stevencheng@aopen.com" <stevencheng@AOPEN.com>,
        "tomchen@aopen.com" <tomchen@AOPEN.com>,
        "donchang@aopen.com" <donchang@AOPEN.com>,
        "milesschofield@aopen.com" <milesschofield@AOPEN.com>
Subject: Re: [PATCH v5 0/2] usb: dwc2: fix isoc split in transfer issue
Thread-Topic: [PATCH v5 0/2] usb: dwc2: fix isoc split in transfer issue
Thread-Index: AQHT6Q0qsr/2hrCuvkKD/isR8OvB0w==
Date: Tue, 29 May 2018 14:30:06 +0000
Message-ID: <3A9D5F5B1BA2034E826C50459B71BE044CB587EA@am04wembxa.internal.synopsys.com>
References: <1526031992-16565-1-git-send-email-william.wu@rock-chips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.71.36]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4TEVTs6029033

On 5/11/2018 1:48 PM, William Wu wrote:
> This patch fix dma unaligned problem and data lost problem for
> isoc split in transfer.
>
> Test on rk3288 platform, use an usb hs Hub (GL852G-12) and an usb
> fs audio device (Plantronics headset) to capture and playback.
>
> William Wu (2):
>   usb: dwc2: alloc dma aligned buffer for isoc split in
>   usb: dwc2: fix isoc split in transfer with no data
>
On HAPS-DX7 with HS HUB Belkin(050d:0233) using internal USB testing tool.
Tested-by: Gevorg Sahakyan <sahakyan@synopsys.com>
