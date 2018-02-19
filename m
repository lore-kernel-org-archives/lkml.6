Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932532AbeBTELR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 23:11:17 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:39366 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932375AbeBTELP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 23:11:15 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Date: Mon, 19 Feb 2018 11:43:29 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
CC: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 5/5] regmap: Remove regmap_get_raw_read_max
Message-ID: <20180219114329.vx7e6jd2ujsbxonx@localhost.localdomain>
References: <20180215175220.2691-1-ckeepax@opensource.cirrus.com>
 <20180215175220.2691-5-ckeepax@opensource.cirrus.com>
 <20180216120311.GG5886@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180216120311.GG5886@sirena.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=875 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802200053
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 12:03:11PM +0000, Mark Brown wrote:
> On Thu, Feb 15, 2018 at 05:52:20PM +0000, Charles Keepax wrote:
> > Since the handling for max_raw_read is now inside regmap_raw_read there
> > should be no need for client drivers to query as max_raw_read.
> 
> No, they might need to know if things are going to be combined into a
> single transaction - some devices have weird sensitivities about bulk
> I/O and so the driver may need to know exactly what's going on when it
> interacts with the device.

True, no objections from me for dropping this one from the chain.

Thanks,
Charles
