Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbeDEMhi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 08:37:38 -0400
Received: from ozlabs.org ([103.22.144.67]:52881 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbeDEMhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 08:37:37 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: yamada.masahiro@socionext.com
Cc: akpm@linux-foundation.org, joe@perches.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: Make SECTION_MISMATCH_WARN_ONLY depend on DEBUG_SECTION_MISMATCH
In-Reply-To: <20180405100055.26585-1-mpe@ellerman.id.au>
References: <20180405100055.26585-1-mpe@ellerman.id.au>
Date: Thu, 05 Apr 2018 22:37:33 +1000
Message-ID: <878ta1u8vm.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:
> CONFIG_SECTION_MISMATCH_WARN_ONLY says to turn the errors enabled by
> CONFIG_DEBUG_SECTION_MISMATCH into warnings. As such there's no need
> to set the former if the latter is not enabled.

Wrong. I get it now.

Please ignore this patch.

cheers
