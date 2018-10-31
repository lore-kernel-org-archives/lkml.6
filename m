Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BB7C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811B520848
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811B520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbeKAE7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:59:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbeKAE7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:59:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BBEAE58E2A;
        Wed, 31 Oct 2018 19:59:39 +0000 (UTC)
Received: from ovpn-120-181.rdu2.redhat.com (ovpn-120-181.rdu2.redhat.com [10.10.120.181])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DC9260851;
        Wed, 31 Oct 2018 19:59:39 +0000 (UTC)
Message-ID: <08ac040dae0417c7ef5ed6f5e2e2614bd14e4134.camel@redhat.com>
Subject: [GIT PULL] c6x changes for 4.20
From:   Mark Salter <msalter@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 31 Oct 2018 15:59:38 -0400
Organization: Red Hat, Inc
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 31 Oct 2018 19:59:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b59dfdaef173677b0b7e10f375226c0a1114fd20:

  i2c-hid: properly terminate i2c_hid_dmi_desc_override_table[] array (2018-10-27 09:10:48 -0700)

are available in the Git repository at:

  git://linux-c6x.org/git/projects/linux-c6x-upstreaming.git tags/for-linus

for you to fetch changes up to 4d8106f0299c7942c5f13a22da6d553d28127ef5:

  c6x: switch to NO_BOOTMEM (2018-10-28 12:25:11 -0400)

----------------------------------------------------------------
c6x changes for 4.20

----------------------------------------------------------------
Mike Rapoport (1):
      c6x: switch to NO_BOOTMEM

 arch/c6x/Kconfig        |  1 +
 arch/c6x/kernel/setup.c | 26 +-------------------------
 2 files changed, 2 insertions(+), 25 deletions(-)


