Return-Path: <kim.phillips@arm.com>
X-Google-Smtp-Source: AB8JxZolhFJMIVWswIgbJo8HFMYW8Kv7tqSSti/B4HKeirCa2N9Yxj39VlMd6nlzB3BAeqEC60U5
ARC-Seal: i=1; a=rsa-sha256; t=1526334569; cv=none;
        d=google.com; s=arc-20160816;
        b=DpuBnBxm6bL7XLoMI6OfNqAMrG/tZBQKsCrL/0t9/mTYXXrjThvSUOSY/8IgsDyvK0
         kVMQH0TDCMmuQF77Zoq4Aj4AQ/23s7aLetPcPJeB52ylXX0eX3U8ZjvITruIHc9wPOCx
         Z2O2IkR1jgJziPkHcpKsoe+CHy0WCd+FlwABfuq4MRgW17b5hyZb4HMeGJFcIp6yPGZI
         WW8szduKVYVmQ7qGbZgeEFW/Z9xYpXn19tKIeZRUQqv2bqlMjj86EecV35VY9LirOZVk
         7HUqCDXNS3afUr6nvQY/TEgqeZzGIp5+MEHOdZlaj5GUhHU2Ya7pHeU5nSI0nCjf4q73
         Rhaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=NsG2hgM+GpPWLCxNy3ILWgr2rU4n74IzOPUAGt4bKbc=;
        b=Xz0WNmEtZ8aBLR5x3sj8C/+W1X9WwAB1mxuFvj1E/BgBpWq74u7FZUrI4ZJILRFgv3
         dm6J++6gXsiAuWx/RdvSpQq1yK1cgBX4X2pfBQzeDwHT1oYT/ltJCw5cP013KX8grjCW
         YIqi2GHwZMfxR4/zp6QFHmWzVVYrflGLmnE0rmFdFWOuASvSp+sRxMtWxGwdsopEcrqy
         Qt+yrgjRPUnEgVrYsSeDCs6gcACXRBz8jJjiAT/SpRYAa2iBrAbXbqb63iRm1E28MYDM
         SjaCtfFWl6ffK/3Soz0r7aPN6vFRxcvHqscaSUqFhGEqHZNH2su9jj7yie9JQRiLPKDK
         tCQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kim.phillips@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=kim.phillips@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kim.phillips@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=kim.phillips@arm.com
Date: Mon, 14 May 2018 16:49:26 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Alex Williamson
 <alex.williamson@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Howells <dhowells@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>, Gargi Sharma <gs051095@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Kirill Tkhai <ktkhai@virtuozzo.com>, Mike Rapoport
 <rppt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Tatashin
 <pasha.tatashin@oracle.com>, Rik van Riel <riel@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Thierry Reding <treding@nvidia.com>, Todd Kjos
 <tkjos@google.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] amba: Export amba_bustype
Message-Id: <20180514164926.61c11b9b96256599491269d9@arm.com>
In-Reply-To: <19c4b830-9f50-d5ea-3e31-587477210ee1@arm.com>
References: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
	<8c2648ec-1379-fb2a-35d2-b3fa8fc9f063@arm.com>
	<20180509154055.GB25559@xps15>
	<19c4b830-9f50-d5ea-3e31-587477210ee1@arm.com>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599923962072715113?=
X-GMAIL-MSGID: =?utf-8?q?1600477797477288583?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 9 May 2018 17:02:34 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> probe (and thus call coresight_register()) first. Oh well, I guess 
> poking amba_bustype really does remain the only reasonable answer.

Thanks all, I've added Robin's Reviewed-by, and submitted this patch to
RMK's patch tracking system, here:

http://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8773/1

Cheers,

Kim
