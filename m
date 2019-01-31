Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19502C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C292087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xEEBLGq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbfAaIKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:10:44 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42834 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfAaIKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:10:43 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0V89Dax072376;
        Thu, 31 Jan 2019 08:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=3voy6zIBkHur9+pvFM+1PirERab/y7Ul2U1rVnE912w=;
 b=xEEBLGq1w9R3WG9WKXYWXehNFcZmO86pC8b/GDyl32CYyYz3zbHoiWTWIZk5Ka0B49TC
 cDqPbqP1YL+Yr78T5gJktGgI+HN5+GV1kxxPhSJ134nGjN8ZEwkqoV1BauK/Hj9rAtUP
 6PGQuSYb25cgpFZ/eQEccrkDY+muJCBilnsVFFK2PTwJtjAvAdk9ycaneeJ+6LI2IWBY
 ze8wqy/jtI77UfGDScsSmmhn3xTan6Wr6YPBp2QnMzy3R/dPapCrJCPfYumBTqUa6FOm
 kcza7MoZ14hGpL1WHYZJI93Ud8Y/6nRP13boZSGMTEDieGRHU9WUtRTiyJHiKM+sM37b 2Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2q8g6rex3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Jan 2019 08:10:29 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0V8AOXR029293
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Jan 2019 08:10:24 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0V8AMvk013389;
        Thu, 31 Jan 2019 08:10:23 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 31 Jan 2019 00:10:22 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.1\))
Subject: Re: [PATCH 1/3] slub: Fix comment spelling mistake
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190131041003.15772-2-me@tobin.cc>
Date:   Thu, 31 Jan 2019 01:10:21 -0700
Cc:     Christopher Lameter <cl@linux.com>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9C8C1658-0418-41A9-9A74-477DB83EB6EF@oracle.com>
References: <20190131041003.15772-1-me@tobin.cc>
 <20190131041003.15772-2-me@tobin.cc>
To:     "Tobin C. Harding" <me@tobin.cc>
X-Mailer: Apple Mail (2.3445.104.1)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9152 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=470 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901310065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 30, 2019, at 9:10 PM, Tobin C. Harding <me@tobin.cc> wrote:
>=20
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
> include/linux/slub_def.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> index 3a1a1dbc6f49..201a635be846 100644
> --- a/include/linux/slub_def.h
> +++ b/include/linux/slub_def.h
> @@ -81,7 +81,7 @@ struct kmem_cache_order_objects {
>  */
> struct kmem_cache {
> 	struct kmem_cache_cpu __percpu *cpu_slab;
> -	/* Used for retriving partial slabs etc */
> +	/* Used for retrieving partial slabs etc */
> 	slab_flags_t flags;
> 	unsigned long min_partial;
> 	unsigned int size;	/* The size of an object including meta =
data */
> --=20

If you're going to do this cleanup, make the comment in line 84 =
grammatical:

/* Used for retrieving partial slabs, etc. */

Then change lines 87 and 88 to remove the space between "meta" and =
"data" as the
word is "metadata" (as can be seen at line 102) and remove the period at =
the end
of the comment on line 89 ("Free pointer offset.")

You might also want to change lines 125-127 to be a single line comment:

/* Defragmentation by allocating from a remote node */

so the commenting style is consistent throughout.=
