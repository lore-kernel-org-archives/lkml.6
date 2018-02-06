Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbeBFKxW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 05:53:22 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36503 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbeBFKxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 05:53:15 -0500
X-Google-Smtp-Source: AH8x227AOSULoRQYJIoOKq3gulbOeYbralsMwA5lDxoqGa8g3rsgnMzVuqcsgTBdird/xhh9DibuSw==
Date: Tue, 6 Feb 2018 11:53:10 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Wang Nan <wangnan0@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 02/10] tooling headers: Synchronize updated s390 kvm UAPI
 headers
Message-ID: <20180206105310.2hi7mjqwu6tkm3lx@gmail.com>
References: <20180205195620.9010-1-acme@kernel.org>
 <20180205195620.9010-3-acme@kernel.org>
 <b2534b23-ea52-4721-e2cb-f838a931b405@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2534b23-ea52-4721-e2cb-f838a931b405@de.ibm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Arnaldo
> 
> what is the proposed way of forwarding kvm uapi changes to the perf copy?
> Are you going to detect and fixup that yourself? Do you want to be notified?
> Or do you even want to have a patch?

Yes, that's the normal flow: you can just ignore any warnings, we are syncing the 
headers up at around -rc1. (Many of them are already synced up.)

I.e. there's no constraint on kernel development and there's no need for you to 
deal with tooling details.

Thanks,

	Ingo
