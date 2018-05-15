Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752956AbeEOLyH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 07:54:07 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:49186 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752580AbeEOLyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 07:54:05 -0400
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Date: Tue, 15 May 2018 12:53:57 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: Re: [PATCH 03/19 v3] regulator: arizona-ldo1: Look up a descriptor
 and pass to the core
Message-ID: <20180515115357.GY20410@imbe.wolfsonmicro.main>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
 <20180514080640.12515-4-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180514080640.12515-4-linus.walleij@linaro.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=812 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1805150123
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:06:24AM +0200, Linus Walleij wrote:
> Instead of passing a global GPIO number, pass a descriptor looked
> up with the standard devm_gpiod_get_optional() call.
> 
> We have augmented the GPIO core to look up the regulator special
> GPIO "wlf,ldoena" in commit 6a537d48461d
> "gpio: of: Support regulator nonstandard GPIO properties".
> 
> Cc: patches@opensource.cirrus.com
> Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
