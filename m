Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751709AbeBTMV2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 07:21:28 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:52960 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751521AbeBTMV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 07:21:26 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Date: Mon, 19 Feb 2018 11:42:04 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: <broonie@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 4/5] iio: accel: bcm150: Remove handling for regmap
 raw_read_max
Message-ID: <20180219114204.nl3zsq55tezy7hvh@localhost.localdomain>
References: <20180215175220.2691-1-ckeepax@opensource.cirrus.com>
 <20180215175220.2691-4-ckeepax@opensource.cirrus.com>
 <20180217140935.74447c0b@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180217140935.74447c0b@archlinux>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802200158
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2018 at 02:09:35PM +0000, Jonathan Cameron wrote:
> On Thu, 15 Feb 2018 17:52:19 +0000
> Charles Keepax <ckeepax@opensource.cirrus.com> wrote:
> 
> > The regmap core now handles splitting up transactions according to
> > max_raw_read, so this code is no longer required in client drivers.
> > 
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Hi Charles,
> 
> This looks fine to me.  I'll need to wait for Mark's patches to work
> their way through to mainline before I can apply this however.
> 
> Please give me a poke when that has happened if it looks like I have
> forgotten it.
> 

Yeah can do.

Thanks,
Charles
