Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639FDC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FF02086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfANIUA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:20:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726092AbfANIT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:19:59 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0E8EUmD118803
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 03:19:58 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q0kw2pg92-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 03:19:58 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <andrew.donnellan@au1.ibm.com>;
        Mon, 14 Jan 2019 08:19:56 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 14 Jan 2019 08:19:53 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0E8JqW257737256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 08:19:52 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3754DAE055;
        Mon, 14 Jan 2019 08:19:52 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D910DAE056;
        Mon, 14 Jan 2019 08:19:51 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jan 2019 08:19:51 +0000 (GMT)
Received: from [10.61.2.125] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id A578FA0104;
        Mon, 14 Jan 2019 19:19:50 +1100 (AEDT)
Subject: Re: [PATCH] docs: Bump version to 5.x
To:     Joel Stanley <joel@jms.id.au>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20190114061221.30494-1-joel@jms.id.au>
From:   Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date:   Mon, 14 Jan 2019 19:19:50 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <20190114061221.30494-1-joel@jms.id.au>
Content-Language: en-AU
X-TM-AS-GCONF: 00
x-cbid: 19011408-0020-0000-0000-0000030624A1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011408-0021-0000-0000-000021573494
Message-Id: <01ca39f9-6114-deed-6e59-d9d6d8d53f76@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-14_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901140071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/1/19 5:12 pm, Joel Stanley wrote:
> This shows up in the index of https://www.kernel.org/doc/html/latest/ so
> I figured it should be updated.
> 
> Fixes: bfeffd15528 ("Linux 5.0-rc1")
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> --
> We could also remove the version number instead of applying this patch.

You missed all the 4.x references in "Installing the kernel source" :)

I also don't think the README matches the contemporary understanding of 
"release notes" so perhaps that phrase should be dropped too.

> ---
>   Documentation/admin-guide/README.rst | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
> index 0797eec76be1..a09baa324951 100644
> --- a/Documentation/admin-guide/README.rst
> +++ b/Documentation/admin-guide/README.rst
> @@ -1,9 +1,9 @@
>   .. _readme:
> 
> -Linux kernel release 4.x <http://kernel.org/>
> +Linux kernel release 5.x <http://kernel.org/>
>   =============================================
> 
> -These are the release notes for Linux version 4.  Read them carefully,
> +These are the release notes for Linux version 5.  Read them carefully,
>   as they tell you what this is all about, explain how to install the
>   kernel, and what to do if something goes wrong.
> 
> @@ -406,3 +406,4 @@ If something goes wrong
> 
>      gdb'ing a non-running kernel currently fails because ``gdb`` (wrongly)
>      disregards the starting offset for which the kernel is compiled.
> +
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

