Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753005AbeBUSSf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 13:18:35 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45867 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752499AbeBUSSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 13:18:31 -0500
X-Google-Smtp-Source: AH8x226lTuX8pTPJ9vma0QRiXjA2fWtko6kb+/XHSnCp/aDNKavrUg51Aji2lQnSNtjmRiJWsgAe4g==
From: Kees Cook <keescook@chromium.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, Will Deacon <will.deacon@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] arm64: cpufeature: Relocate PAN emulation report
Date: Wed, 21 Feb 2018 10:18:20 -0800
Message-Id: <1519237102-46854-1-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This splits the PAN emulation report relocation and the cpufeatures
reporting wording adjustment patches, as discussed with Mark and Dave.

Thanks!

-Kees
