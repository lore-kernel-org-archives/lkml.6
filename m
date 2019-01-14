Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA44C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37E920660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfANHmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 02:42:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55142 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726067AbfANHmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 02:42:44 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0E7cWCw005515
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 02:42:43 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q0k66pr27-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 02:42:42 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 14 Jan 2019 07:42:40 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 14 Jan 2019 07:42:38 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0E7gbf961079604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 07:42:37 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E1854204B;
        Mon, 14 Jan 2019 07:42:37 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABC0942041;
        Mon, 14 Jan 2019 07:42:36 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.170])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 14 Jan 2019 07:42:36 +0000 (GMT)
Date:   Mon, 14 Jan 2019 09:42:34 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Joel Nider <joeln@il.ibm.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs-rst: doc-guide: Minor grammar fixes
References: <1547450099-3534-1-git-send-email-joeln@il.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547450099-3534-1-git-send-email-joeln@il.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19011407-0020-0000-0000-0000030620DF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011407-0021-0000-0000-0000215730A2
Message-Id: <20190114074233.GA1973@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-14_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=857 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901140066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 09:14:59AM +0200, Joel Nider wrote:
> While using this guide to learn the new documentation method, I saw
> a few phrases that I felt could be improved. These small changes
> improve the grammar and choice of words to further enhance the
> installation instructions.
> 
> Signed-off-by: Joel Nider <joeln@il.ibm.com>
> Acked-by: Matthew Wilcox <willy@infradead.org>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
> v2: address Matthew's comment
> 
>  Documentation/doc-guide/sphinx.rst | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
> index 02605ee..c039224 100644
> --- a/Documentation/doc-guide/sphinx.rst
> +++ b/Documentation/doc-guide/sphinx.rst
> @@ -27,8 +27,8 @@ Sphinx Install
>  ==============
>  
>  The ReST markups currently used by the Documentation/ files are meant to be
> -built with ``Sphinx`` version 1.3 or upper. If you're desiring to build
> -PDF outputs, it is recommended to use version 1.4.6 or upper.
> +built with ``Sphinx`` version 1.3 or higher. If you desire to build
> +PDF output, it is recommended to use version 1.4.6 or higher.
>  
>  There's a script that checks for the Sphinx requirements. Please see
>  :ref:`sphinx-pre-install` for further details.
> @@ -37,15 +37,15 @@ Most distributions are shipped with Sphinx, but its toolchain is fragile,
>  and it is not uncommon that upgrading it or some other Python packages
>  on your machine would cause the documentation build to break.
>  
> -A way to get rid of that is to use a different version than the one shipped
> -on your distributions. In order to do that, it is recommended to install
> +A way to avoid that is to use a different version than the one shipped
> +with your distributions. In order to do so, it is recommended to install
>  Sphinx inside a virtual environment, using ``virtualenv-3``
>  or ``virtualenv``, depending on how your distribution packaged Python 3.
>  
>  .. note::
>  
>     #) Sphinx versions below 1.5 don't work properly with Python's
> -      docutils version 0.13.1 or upper. So, if you're willing to use
> +      docutils version 0.13.1 or higher. So, if you're willing to use
>        those versions, you should run ``pip install 'docutils==0.12'``.
>  
>     #) It is recommended to use the RTD theme for html output. Depending
> @@ -82,7 +82,7 @@ output.
>  PDF and LaTeX builds
>  --------------------
>  
> -Such builds are currently supported only with Sphinx versions 1.4 and upper.
> +Such builds are currently supported only with Sphinx versions 1.4 and higher.
>  
>  For PDF and LaTeX output, you'll also need ``XeLaTeX`` version 3.14159265.
>  
> -- 
> 2.7.4
> 

-- 
Sincerely yours,
Mike.

