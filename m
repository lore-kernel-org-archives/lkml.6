Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752678AbeCUPSZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:18:25 -0400
Received: from ms.lwn.net ([45.79.88.28]:50018 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752385AbeCUPSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:18:21 -0400
Date: Wed, 21 Mar 2018 09:18:19 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Eric Engestrom <eric.engestrom@imgtec.com>
Cc: <linux-kernel@vger.kernel.org>, Jiri Kosina <trivial@kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: Re: [trivial PATCH] Documentation/sparse: fix typo
Message-ID: <20180321091819.3d519a2c@lwn.net>
In-Reply-To: <20180313111128.5803-1-eric.engestrom@imgtec.com>
References: <20180313111128.5803-1-eric.engestrom@imgtec.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2018 11:10:58 +0000
Eric Engestrom <eric.engestrom@imgtec.com> wrote:

>  If the function enters and exits without the lock held, acquiring and
>  releasing the lock inside the function in a balanced way, no
> -annotation is needed.  The tree annotations above are for cases where
> +annotation is needed.  The three annotations above are for cases where
>  sparse would otherwise report a context imbalance.

Applied to the docs tree, thanks.

jon
