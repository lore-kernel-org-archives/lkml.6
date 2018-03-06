Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELtGI87/Ub4Z5mbknaxK9sePiYc9PaBNLxfuqocR1cxnYWN4WijGzcEGYKUYGRznY7XDm0NC
ARC-Seal: i=1; a=rsa-sha256; t=1520295505; cv=none;
        d=google.com; s=arc-20160816;
        b=W3BeiSgMklrZ1jqQT7iQVvUoQ5Ue2an2PAHncsq8GWm09Ih/2RHavQNl1QhuW7N+yH
         VfU8jnzTnyQjAvWMpjyAOpDd6twRoNl/Jxd10Rc+MNRq/vIuNv2+8QNt3zu+giH4xPhf
         fZjTmIt1OsmiS2xp2aKTXoDDedEqRjDYka5fNs7UuZ8GmyAtAWRL097jvGhgbNx01ADx
         TO7DtrYUuvO32qcNDajkNp1LRByWCAlYaXmoYkyHe91EeJNJHeVjGSV+N96OnaqBmH1l
         XR4eNRGOe9drk2+YTAeOjsyRtIqYH63+pa2F2aUS+fqcLgc/NDD/FJd1MAO8hWc0PKrT
         Dj5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=bhvQwPmK/qGSgRJI2KOStzagcDlQQvRHuRzs7i0wP2c=;
        b=XocqAQBGwztSpyt+OjCD/uy6P6/yV5zBaPPeJ589NUfNhuxP80NNYPUO65KU2ruFrM
         gTXy6DvnKeXTF8jsJ5vrLdMlnB+hT6hoGeqnSL4iZh5XQhx/b5Hww2WovonbrF4VoqaS
         ubtP+i+zd07oRuGKKYjL4JmbGAWiZ02YPPUPa5sYKi9ksWWnTfcbvYWtZkLTwyOwaQON
         AGlkJJdwe+gcsO3Nxjr9FcJjkFWOkqutagxO/Yq6C+1VgNzExi1cnhy6lPDSNJWwhKJp
         19C5RENWfa7o+wvreGOEmSu5fF3urFiHkkDrmU3ciSFJaptGH431wD5w+P33byFzGJMb
         fQ7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@infradead.org header.s=bombadil.20170209 header.b=bgDiSXCd;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@infradead.org header.s=bombadil.20170209 header.b=bgDiSXCd;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932287AbeCFASZ (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 5 Mar 2018 19:18:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33116 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932218AbeCFASY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Mar 2018 19:18:24 -0500
Date: Mon, 5 Mar 2018 16:18:20 -0800
From: Darren Hart <dvhart@infradead.org>
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: shuah@kernel.org, tbird20d@gmail.com, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] selftests: futex Makefile add top level TAP header
 echo to RUN_TESTS
Message-ID: <20180306001820.GF25693@fury>
References: <20180301201907.17573-1-shuahkh@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301201907.17573-1-shuahkh@osg.samsung.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593767962911316222?=
X-GMAIL-MSGID: =?utf-8?q?1594145380093144436?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 01:19:07PM -0700, Shuah Khan wrote:
> Add top level TAP header echo, testname and separator line to make
> the output consistent with the common run_tests target.
> 
> This change prevents nested TAP13 headers output from individual tests.
> Nested TAP13 headers could cause problems for some parsers.
> 
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>


Reviewed-by: Darren Hart (VMware) <dvhart@infradead.org>


-- 
Darren Hart
VMware Open Source Technology Center
