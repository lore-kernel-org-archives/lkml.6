Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754617AbeDWJ5G (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:57:06 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:54330 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754456AbeDWJ5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:57:05 -0400
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Date: Mon, 23 Apr 2018 09:53:53 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 13/18 v2] regulator: wm8994: Pass descriptor instead of
 GPIO number
Message-ID: <20180423085353.c567qjqtynamrmlp@localhost.localdomain>
References: <20180422230742.3729-1-linus.walleij@linaro.org>
 <20180422230742.3729-13-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180422230742.3729-13-linus.walleij@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=722 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1804230107
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 01:07:37AM +0200, Linus Walleij wrote:
> Instead of passing a global GPIO number for the enable GPIO, pass
> a descriptor looked up from the device tree node or the board file
> decriptor table for the regulator.
> 
> There is a single board file passing the GPIOs for LDO1 and LDO2
> through platform data, so augment this to pass descriptors
> associated with the i2c device as well.
> 
> The special GPIO enable DT property for the enable GPIO is
> nonstandard but this was accomodated in
> commit 6a537d48461deacc57c07ed86d9915e5aa4b3539
> "gpio: of: Support regulator nonstandard GPIO properties".
> 
> Cc: patches@opensource.cirrus.com
> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Rebase the patch on the other changes.
> - Collect Lee's ACK.
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
