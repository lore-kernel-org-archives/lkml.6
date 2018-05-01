Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755810AbeEAMPF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 08:15:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755267AbeEAMKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 08:10:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955C723695
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jwboyer@kernel.org
X-Google-Smtp-Source: AB8JxZo2RfGFrxq6bFDECCR7A/A94HZtEwEbcZGxVoJEdn+o7xXwP1B9dOm2/VnV0e4Z690PiqEhIfA1svCKtKXnQ1k=
MIME-Version: 1.0
In-Reply-To: <20180425150635.GA4753@chelsio.com>
References: <20180425150635.GA4753@chelsio.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Tue, 1 May 2018 08:10:37 -0400
X-Gmail-Original-Message-ID: <CA+5PVA6f5Jqn29Pn0a5yxkcvypWR4h5baGmdk7FTN_APG0T_XA@mail.gmail.com>
Message-ID: <CA+5PVA6f5Jqn29Pn0a5yxkcvypWR4h5baGmdk7FTN_APG0T_XA@mail.gmail.com>
Subject: Re: pull request: linux-firmware: update cxgb4 firmware
To: Ganesh Goudar <ganeshgr@chelsio.com>
Cc: Linux Firmware <linux-firmware@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        nirranjan@chelsio.com, indranil@chelsio.com,
        Arjun V <arjun@chelsio.com>, venkatesh@chelsio.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 11:06 AM, Ganesh Goudar <ganeshgr@chelsio.com> wrote:
> Hi,
>
> Kindly pull the new firmware from the following URL.
> git://git.chelsio.net/pub/git/linux-firmware.git for-upstream
>
> Thanks
> Ganesh
>
> The following changes since commit 0caed67f661bfa9552b636d1e4af379eda75ed67:
>
>   cxgb4: update firmware to revision 1.19.1.0 (2018-04-25 07:48:21 -0700)
>
> are available in the git repository at:
>
>   git://git.chelsio.net/pub/git/linux-firmware.git for-upstream
>
> for you to fetch changes up to 0caed67f661bfa9552b636d1e4af379eda75ed67:
>
>   cxgb4: update firmware to revision 1.19.1.0 (2018-04-25 07:48:21 -0700)
>
> ----------------------------------------------------------------

If you could update your pull request script to include a diffstat,
that would be appreciated.

Pulled and pushed out.  Thanks.

josh
