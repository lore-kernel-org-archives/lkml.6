Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF20C282C2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 01:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72DFA20811
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 01:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfBKByI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 20:54:08 -0500
Received: from smtprelay0245.hostedemail.com ([216.40.44.245]:52413 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726101AbfBKByI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 20:54:08 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 31789180286DE;
        Mon, 11 Feb 2019 01:54:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fruit71_68c173c99003
X-Filterd-Recvd-Size: 2307
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Mon, 11 Feb 2019 01:54:04 +0000 (UTC)
Message-ID: <7befaea3d1a86950f9dd270fed47072214fa2876.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: use tab instead of spaces
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linuxibm.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 10 Feb 2019 17:54:03 -0800
In-Reply-To: <20190210181011.6117-1-lukas.bulwahn@gmail.com>
References: <20190210181011.6117-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-02-10 at 19:10 +0100, Lukas Bulwahn wrote:
> Mimi Zohar used spaces instead of a tab when adding Jarkko Sakkinen as
> further maintainer to the KEYS-TRUSTED section entry. So, we rectify this
> with this commit.
> 
> The issue was detected when writing a script that parses MAINTAINERS.

checkpatch already does that btw:

$ ./scripts/checkpatch.pl -f MAINTAINERS
WARNING: MAINTAINERS entries use one tab after TYPE:
#8408: FILE: MAINTAINERS:8408:
+M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

WARNING: MAINTAINERS entries use one tab after TYPE:
#12607: FILE: MAINTAINERS:12607:
+M:  Ilia Lin <ilia.lin@gmail.com>

WARNING: MAINTAINERS entries use one tab after TYPE:
#12608: FILE: MAINTAINERS:12608:
+L:  linux-pm@vger.kernel.org

WARNING: MAINTAINERS entries use one tab after TYPE:
#12609: FILE: MAINTAINERS:12609:
+S:  Maintained

WARNING: MAINTAINERS entries use one tab after TYPE:
#12610: FILE: MAINTAINERS:12610:
+F:  Documentation/devicetree/bindings/opp/kryo-cpufreq.txt

WARNING: MAINTAINERS entries use one tab after TYPE:
#12611: FILE: MAINTAINERS:12611:
+F:  drivers/cpufreq/qcom-cpufreq-kryo.c

total: 0 errors, 6 warnings, 16993 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace



