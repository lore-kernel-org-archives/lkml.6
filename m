Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754692AbeDWJ6V (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:58:21 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:54816 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754130AbeDWJ6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:58:14 -0400
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Date: Mon, 23 Apr 2018 09:42:50 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Colin King <colin.king@canonical.com>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        <patches@opensource.cirrus.com>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: wm8350: fix missing increment of loop index i
Message-ID: <20180423084250.aqsk7lo7oju76z6t@localhost.localdomain>
References: <20180420092623.1327-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180420092623.1327-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=606 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1804230107
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 10:26:23AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> It seems that the loop index i is not being incremented and hence
> potentially the while loop could spin forever. Fortunately with the
> data being used this does not appear to happen at the moment.
> 
> Fixes: da09155ac8d3 ("regulator: Add WM8350 regulator support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
