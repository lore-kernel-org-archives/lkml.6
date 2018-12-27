Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3EEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290FD21908
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545948317;
	bh=EiXq9HRxGheLmnVgq800w7Ch5vj/wTswhR4kNBhUUyk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jdTJ4e7Se54TXezU1lAemDWN9jrshjNDn/FwIuy0OOhaxLqhk0xZDlBNh3h8oDFF2
	 t0VyzMn7KKf2dWJO0fb4kWxPJghlbVIiEPAxXdE+3EjRv2ypKRdAAXySauUYui80IJ
	 GK8HfzA12CkKqK2PHt5pZ9In32JY+TT8NPu1pqsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731520AbeL0WFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 17:05:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731548AbeL0WFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 17:05:06 -0500
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-4.21-1 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545948305;
        bh=EiXq9HRxGheLmnVgq800w7Ch5vj/wTswhR4kNBhUUyk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fP9k8+COUNpEbwtzPaX35YihI2pBfladLdD8RAJrEb+GPcQ+y+V+7yG5rI0+V9WSb
         DPOYZA7XGvAIrkhQQZTlQqLgq4EHHnlSX4586jo0Bn5U82a3dwYu18/QDKATws4pQD
         EJU/0ZHQRgiT23vpHTqQEOuT8fAdN+NKeVxklXMk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87o997xju9.fsf@concordia.ellerman.id.au>
References: <87o997xju9.fsf@concordia.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87o997xju9.fsf@concordia.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-4.21-1
X-PR-Tracked-Commit-Id: 12526b0d6c580df860b31e59d68e5696e16c6e5b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d6973327ee84c2f40dd9efd8928d4a1186c96e2
Message-Id: <20181227220505.24636.75727.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Thu, 27 Dec 2018 22:05:05 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, aik@ozlabs.ru,
        alex.williamson@redhat.com, alexandre.belloni@bootlin.com,
        alistair@popple.id.au, andrew.donnellan@au1.ibm.com,
        andy.tang@nxp.com, aneesh.kumar@linux.ibm.com, arnd@arndb.de,
        benh@kernel.crashing.org, christophe.leroy@c-s.fr,
        darren@stevens-zone.net, diana.craciun@nxp.com, dja@axtens.net,
        elfring@users.sourceforge.net, fbarrat@linux.ibm.com,
        firoz.khan@linaro.org, geert+renesas@glider.be, groug@kaod.org,
        hch@lst.de, joel@jms.id.au, ldv@altlinux.org, leitao@debian.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linuxram@us.ibm.com, maddy@linux.vnet.ibm.com,
        mahesh@linux.vnet.ibm.com, malat@debian.org, oohall@gmail.com,
        oss@buserror.net, ravi.bangoria@linux.ibm.com, robh@kernel.org,
        ruscur@russell.cc, sabyasachi.linux@gmail.com,
        sathnaga@linux.vnet.ibm.com, sboyd@kernel.org,
        sfr@canb.auug.org.au, tiny.windzz@gmail.com,
        viresh.kumar@linaro.org, yuehaibing@huawei.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Dec 2018 22:58:06 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.21-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d6973327ee84c2f40dd9efd8928d4a1186c96e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
