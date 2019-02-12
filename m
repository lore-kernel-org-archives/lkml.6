Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842DEC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5809020838
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbfBLOHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:07:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:36642 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730147AbfBLOHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:07:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CD30BAC69;
        Tue, 12 Feb 2019 14:07:46 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv\@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 6/6] RISC-V: Implement keepinitrd kernel parameter
References: <20190212135942.105008-1-anup.patel@wdc.com>
        <20190212135942.105008-7-anup.patel@wdc.com>
X-Yow:  FROZEN ENTREES may be flung by members of opposing SWANSON SECTS..
Date:   Tue, 12 Feb 2019 15:07:45 +0100
In-Reply-To: <20190212135942.105008-7-anup.patel@wdc.com> (Anup Patel's
        message of "Tue, 12 Feb 2019 14:01:19 +0000")
Message-ID: <mvmmun1rtfy.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 12 2019, Anup Patel <Anup.Patel@wdc.com> wrote:

> This patch implements keepinitrd kernel parameter. By default,
> keepinitrd=0 so initrd memory will be freed by default freed but

-freed

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
