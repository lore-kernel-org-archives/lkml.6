Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753440AbeFAUFT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 16:05:19 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:55285 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeFAUFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 16:05:17 -0400
Date: Fri, 1 Jun 2018 22:05:07 +0200 (CEST)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel@lists.infradead.or,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Message-ID: <457305318.78169.1527883507093@email.1und1.de>
Subject: linux-next-20180601: build error in arch/arm64/kvm/hyp/hyp-entry.S
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev28
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:KZ6XVmokppaukSOrNqSxDP9FwRoLHb0HjZp6TgZERikhpAN8TQk
 QLARIy97H5lkktcLDs5AWN9krNE7RpHCugv8tPpO4w3205hOOj6qnTmHUJbrm1k7oBwVtvn
 ou/vxtrRsHkI0zxO9g3NRWjsjKTtb+qWwSokm5ejLUzNQyaAETpd0Z6YG2nw92Klkp7ISNP
 8guyHCIeVcCv76s7+Po4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GOsx1d/cxbU=:Fk4GezJu2/hyx9GLoh4dmy
 JzvBVCY4vnmT4CKM5Jj2H35VNECEJRpDcxOCqUYsJiMc4hMZB7zqeid/NG8gQrJWSGWp0C2Iv
 FjJZC8CZjMCqft5h+OSvrc1RH9eIriGVIiLwD47Q3Qa8whysfAVNdwrUhAIfJ2ZIv7d9urqcp
 a9/vYl+jFk291OWAAsGli2z/tIfEZdUFR5jzmFgESvEwuqsECAV05+KoZy18sxrDAe3wGoGBO
 RIPIeo8xupqWqUNczollt3vMnzGIqiwe7FpuMhy+fd1uB202h84W3gn/TG/fAk5mc1h1ZUoO0
 tvtlm9bOrP57wDxADIfRU4tIRsEbfzo6TCxnCHdgHdiZYapJJanIWPRJia2/AzygYgbcUbkGI
 mtrs+fL3GW2mUXJ/D2lQOxZQw4hB+jPxUoBYrzoBKUVQ2VefDUOM+nHSNOkMEwiYwTuVN1kcC
 p8NMxhhCpGRyAQ5lWy83aGghRwBWByHU+ykkxvJCrPNzM7GhE8JFI8u/i4dgAhVAHBdSqkAQs
 b6oBZH6SEjH3oR11EJV1pSWHtN5CjktovgeN5D3mdhDBK10vTj7wRoNL+FEs/9CDU11rpfAZ4
 LBqsAUXayDWPWHB9nz1i4TNF1jVX8vf1Vy+DEzKl16wguc9XTNsmmZZDA9HusJaH8oc8tdin+
 1HkxE50X/UdX+hr8XLLSZJ4wQv2bDhhLL5MzqevwXsD+rWkvguHNyp04aJua2CyHxJ1gRobkA
 biaE+hsoSp+HKsA2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i can't build todays linux-next-20180601 and get the following error message:

arch/arm64/kvm/hyp/hyp-entry.S: Assembler messages:
arch/arm64/kvm/hyp/hyp-entry.S:128: Error: constant expression required at operand 3 -- `bfi x0,x1,#VCPU_WORKAROUND_2_FLAG_SHIFT,#1'

Related commit:
arm64: KVM: Handle guest's ARCH_WORKAROUND_2 requests

Toolchain: gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu
Kernel config: arm64/defconfig

Regards
Stefan
