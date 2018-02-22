Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752689AbeBVHoH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 02:44:07 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41910 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752658AbeBVHoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 02:44:04 -0500
Date: Thu, 22 Feb 2018 10:43:18 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Daniel Baluta <daniel.baluta@nxp.com>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio:dummy: Replace S_IWUSR by 0200
Message-ID: <20180222074318.qsf7x4jnyhvasq5u@mwanda>
References: <20180221192807.qfyhp7z27f6r6p47@smtp.gmail.com>
 <CAEnQRZBq3G+RPq66ObW+CM2A9BOE_tBn-fC++Ksy+O_nEFfz9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEnQRZBq3G+RPq66ObW+CM2A9BOE_tBn-fC++Ksy+O_nEFfz9Q@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8811 signatures=668676
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=499
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802220099
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 11:01:50PM +0200, Daniel Baluta wrote:
> On Wed, Feb 21, 2018 at 9:28 PM, Rodrigo Siqueira
> <rodrigosiqueiramelo@gmail.com> wrote:
> > This patch fixes the checkpatch.pl warning:
> >
> > drivers/iio/dummy/iio_dummy_evgen.c:151: WARNING: Symbolic permissions
> > 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
> 
> > ... Why this "..." :)?
> 
> Commit subject could be done better. It is pretty obvious from the code that
> we change S_IWUSR with 0200.
> 
> Better message:
> 
> iio:dummy: Fix poke_evN file permissions

Please stop telling people to say "Fix" when it's not a bug fix...

Also who cares?  The commit message is perfectly clear.

regards,
dan carpenter
