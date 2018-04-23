Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754733AbeDWK1b (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:27:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33558 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754442AbeDWK10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:27:26 -0400
Date: Mon, 23 Apr 2018 13:27:17 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] mfd: tps65911-comparator: Fix an off by one bug
Message-ID: <20180423102717.tmx7mlk2yzovnpkh@mwanda>
References: <20180420083909.66a6t63s5q6vpwp7@dell>
 <20180420090910.GA26071@mwanda>
 <20180423064417.2e2ng3su23w4i7hx@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423064417.2e2ng3su23w4i7hx@dell>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8871 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=356
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804230113
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I really don't want authorship credit for a patch that does:

#define COMP1 0
#define COMP2 1

It just makes me itch to look at it...

regards,
dan carpenter
