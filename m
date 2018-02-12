Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754184AbeBLOHu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 09:07:50 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:54961 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754154AbeBLOHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 09:07:49 -0500
X-Google-Smtp-Source: AH8x224tSlAbOktQJtrXE+SQEveeD8Qbow17MNA4YCr5xnH/xAZ3EtyRzOb7IZ0sqIVMXKpt8rW1oQ==
Date: Mon, 12 Feb 2018 17:07:46 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 1/2] mm/page_ref: use atomic_set_release in
 page_ref_unfreeze
Message-ID: <20180212140746.3gojy7ybiq763pj3@node.shutemov.name>
References: <4f64569f-b8ce-54f8-33d9-0e67216bb54c@yandex-team.ru>
 <151844393004.210639.4672319312617954272.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151844393004.210639.4672319312617954272.stgit@buzz>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 04:58:50PM +0300, Konstantin Khlebnikov wrote:
> page_ref_unfreeze() has exactly that semantic. No functional
> changes: just minus one barrier and proper handling of PPro errata.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
