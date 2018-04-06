Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbeDFHXZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 03:23:25 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:41797 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbeDFHXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 03:23:24 -0400
X-Google-Smtp-Source: AIpwx48MY2tgP05qvAaHYIPK/PAx7Cr9cnXV9TfkDCQgMJ7Hnxmk3PzHarKLj2RDeQ7p/OqTuyL90w==
Date: Fri, 6 Apr 2018 00:23:18 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, Xiubo.Lee@gmail.com
Subject: Re: regression, imx6 and sgtl5000 sound problems
Message-ID: <20180406072317.GA10500@Asurada>
References: <f9a166cb-9584-5553-bb72-35b22a0652d7@nextfour.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9a166cb-9584-5553-bb72-35b22a0652d7@nextfour.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 07:46:37AM +0300, Mika Penttilä wrote:
> 
> With recent merge to pre 4.17-rc, audio stopped workin (or it's hearable but way too slow).
> imx6q + sgtl5000 codec.

Could you please be more specific at your test cases?

Which board? Whose is the DAI master? Which sample rate?

> Maybe some of the soc/fsl changes is causing this.

There are quite a few clean-up patches of SSI driver being merged.
Would you please try to revert/bisect the changes of fsl_ssi driver
so as to figure out which one breaks your test cases?

If there is a regression because of one of the changes, I will need
to fix it.

Thanks
Nicolin
