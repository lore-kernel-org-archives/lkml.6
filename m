Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F80C070C3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 01:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6919220659
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 01:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6919220659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbeJOJ3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 05:29:42 -0400
Received: from smtprelay0077.hostedemail.com ([216.40.44.77]:53055 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726186AbeJOJ3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 05:29:42 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 39FCE182244F3;
        Mon, 15 Oct 2018 01:46:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: jelly01_9160a6ff9a51c
X-Filterd-Recvd-Size: 2088
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Mon, 15 Oct 2018 01:46:38 +0000 (UTC)
Message-ID: <97e8ce1370ed45b771538c67712920322ecdd3aa.camel@perches.com>
Subject: Re: [PATCH] Fix Code of Conduct ambiguities
From:   Joe Perches <joe@perches.com>
To:     Ivan Chavero <ichavero@chavero.com.mx>, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org
Date:   Sun, 14 Oct 2018 18:46:37 -0700
In-Reply-To: <20181014185241.4085197-1-ichavero@chavero.com.mx>
References: <20181014185241.4085197-1-ichavero@chavero.com.mx>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-10-14 at 13:52 -0500, Ivan Chavero wrote:
> The language and focus of the CoC has some ambiguities that
> could lead to conflicts that might distract maintainers and
> contributors attention from the technical nature of the
> Linux kernel.
> This patch aims to clarify this problems and focus the document
> to a more possitive, healthy and technical standpoint.
[]
> diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/process/code-of-conduct.rst
[]
> @@ -17,23 +19,22 @@ Our Standards
>  Examples of behavior that contributes to creating a positive environment
>  include:
>  
> -* Using welcoming and inclusive language
> -* Being respectful of differing viewpoints and experiences
> -* Gracefully accepting constructive criticism
> -* Focusing on what is best for the community
> -* Showing empathy towards other community members
> +* Using welcoming and inclusive language.
> +* Being respectful of differing viewpoints and experiences.
> +* Gracefully accepting constructive criticism.
> +* Focusing on what is best for the community:.
> +* Showing empathy towards other community members.
> +* Use facts instead of opinions.

trivia:

bullet points do not need periods.


