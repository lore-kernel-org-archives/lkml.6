Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752779AbeBVI0H (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 03:26:07 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35124 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752701AbeBVI0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 03:26:05 -0500
Date: Thu, 22 Feb 2018 11:25:27 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "rodrigosiqueiramelo@gmail.com" <rodrigosiqueiramelo@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2] iio:dummy: Replace S_IWUSR by 0200
Message-ID: <20180222082527.wbiztlla4aondbeu@mwanda>
References: <20180221192807.qfyhp7z27f6r6p47@smtp.gmail.com>
 <CAEnQRZBq3G+RPq66ObW+CM2A9BOE_tBn-fC++Ksy+O_nEFfz9Q@mail.gmail.com>
 <20180222074318.qsf7x4jnyhvasq5u@mwanda>
 <1519286013.13463.59.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1519286013.13463.59.camel@nxp.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8811 signatures=668676
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=405
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802220108
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Also who cares?  The commit message is perfectly clear.
> 
> I do care about newcomers really learning on how to write a proper
> commit message.
> 
> The commit messsage should really say why the patch is needed, no what the patch does.
> 

It fixes a checkpatch warning.  The warning was right there in the patch
description!

> After several trivial patches newcomers will get into more serious stuff and I wouldn't
> want to see a patch with commit message like this:
> 
> iio: Change bit 1 of status register
> 

You seem to be complaining about about an imaginary patch from the
future???  If you've really built a time machine then focus on killing
Hitler instead of complaining about trivial bullshit.

regards,
dan carpenter
