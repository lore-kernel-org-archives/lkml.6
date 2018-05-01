Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755768AbeEANLf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 09:11:35 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47190 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755345AbeEANLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 09:11:23 -0400
Date: Tue, 1 May 2018 16:10:36 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] mfd: tps65911-comparator: Fix an off by one bug
Message-ID: <20180501131036.bm7rcujohxi5devs@mwanda>
References: <20180501094553.31545-1-lee.jones@linaro.org>
 <54e604bd-61cd-63a8-1d35-864137a5b19a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54e604bd-61cd-63a8-1d35-864137a5b19a@arm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8879 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=808
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805010132
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The background is that no one noticed that this driver stopped being
buildable in 2012 until I fixed it last week.  This is the third
proposed patch to fix the off by one.  All three patches fix the bug,
but Lee refused to accept my style and I refused to use Lee's style...
Absolutely *no way*!  LOL.  But really neither of us take it personally
and we've met in person before and collaborate over email and get along.

This thread has been pretty amusing for me, but let's move on.  :P

regards,
dan carpenter
