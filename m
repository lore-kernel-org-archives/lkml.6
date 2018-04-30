Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbeD3H0p (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 03:26:45 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:49997 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751751AbeD3H0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 03:26:44 -0400
X-UUID: 661a9bd7db0041d8b3e077538f54e989-20180430
Message-ID: <1525073196.21494.3.camel@mtkswgap22>
Subject: Re: [PATCH] spi: mediatek: Use of_device_get_match_data()
From: Ryder Lee <ryder.lee@mediatek.com>
To: Mark Brown <broonie@kernel.org>
CC: Leilk Liu =?UTF-8?Q?=28=E5=88=98=E7=A3=8A=29?=
        <Leilk.Liu@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org"
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Date: Mon, 30 Apr 2018 15:26:36 +0800
In-Reply-To: <94cba80f703be048666afde1ed53c15c3704c533.1523347340.git.ryder.lee@mediatek.com>
References: <31f944ab8dfcc1d7b6f03b35657a2a34825b5246.1523347340.git.ryder.lee@mediatek.com>
         <94cba80f703be048666afde1ed53c15c3704c533.1523347340.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Is it okay with you?

On Mon, 2018-04-16 at 10:33 +0800, Ryder Lee (李庚?V) wrote:
> The usage of of_device_get_match_data() reduce the code size a bit.
> 
> Also, the only way to call mtk_spi_probe() is to match an entry in
> mtk_spi_of_match[], so of_id cannot be NULL.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/spi/spi-mt65xx.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
