Return-Path: <daniel.vetter@ffwll.ch>
ARC-Seal: i=1; a=rsa-sha256; t=1522855029; cv=none;
        d=google.com; s=arc-20160816;
        b=DMVUKioZA7Kg76jO/BwnDOPHhLRdp/iunr+rt7IcXaV+Itolmljczkne1ntB3iy6AA
         DHcu/PwEHu/kbLEW0q+fApRzWnGCAavxkYBhIPwncXiVu0oJOEUdMqMoTzhFmIE8LUpD
         3zSqlzgyO9HSpBoKOezTPreKdh+mWO79BGvDMsKW4YM4ixssPm8VpwpOOUgDZDP+zbXP
         2ynCdIgkgjrhqcXq9cqug4mLmybvBcqjHptUNdTTgP23TDBw5Y7NhXMaDIyJvYMyMKzH
         9U8hhsZA9D0lL/zqqsC9WPYd8IQYPV3tbwG8W1MV2VmaTpT55H+SXdtsmQuET1uhfLtJ
         yjzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=yO8ILhZrDNJEP5dsAWT/YQaEMbDhimblfKeygwdNs8g=;
        b=pkHzVyNwdeULce0CemPv7x9fU6DRTQ9KgamSdKfb6dzg6o28fWXFL6bDnfqXkgYuyq
         M3v/he/yoGqV/432u/3CBLhxnczGLX8iOPI/EyKMB36/mKwUkdFjTUwXCsbEX+5qGbvT
         nqmx53z9ruykVLQMv4W0eCQC+NZZY9VOBXKl+97wZNFp5u9ipeZozmxyjjK38Y9SIqsq
         6ddycpDyf1/0SLTbu4c76IyxI3YFUQNA5DZn4RrYLybd3dsTyizI/185bwO4Iwqpindw
         DyPk5s/mCgq3SxZeuGGuDNoRBVyCgEM04wy2BFL6Cxj8FNHZP2JpG6XxemEnLxtaZDJ2
         oQ4A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ffwll.ch header.s=google header.b=XG8Invrn;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of daniel.vetter@ffwll.ch) smtp.mailfrom=daniel.vetter@ffwll.ch
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ffwll.ch header.s=google header.b=XG8Invrn;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of daniel.vetter@ffwll.ch) smtp.mailfrom=daniel.vetter@ffwll.ch
X-Google-Smtp-Source: AIpwx48AGFI0USklu7h3d65xWgnajdgdm5Biw+H00vx2yJ2x4kfd1p9TypTY3iPtasCvi6kXbWkisInjp9JI7z45stY=
MIME-Version: 1.0
X-Originating-IP: [212.51.149.109]
In-Reply-To: <20180404143050.GA20964@kroah.com>
References: <20180404103037.11581-1-daniel.vetter@ffwll.ch>
 <222a21c2-6de0-d8a8-852a-35786af76a5a@redhat.com> <20180404143050.GA20964@kroah.com>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Wed, 4 Apr 2018 17:17:08 +0200
Message-ID: <CAKMK7uGmtoTiYZ0dCjt44E+1HFFCLFdpoVJYS8o2cK6unzAe9w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add dri-devel&linaro-mm for Android ION
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Laura Abbott <labbott@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>, driverdevel <devel@driverdev.osuosl.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	"moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596811215801988069?=
X-GMAIL-MSGID: =?utf-8?q?1596829235183097909?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 4:30 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Apr 04, 2018 at 07:17:39AM -0700, Laura Abbott wrote:
>> On 04/04/2018 03:30 AM, Daniel Vetter wrote:
>> > Most of the other cross-driver gfx infrastructure (dma_buf, dma_fence)
>> > also gets cross posted to all the relevant gfx/memory lists. Doing the
>> > same for ION means people won't miss relevant patches.
>> >
>>
>> No problem from me, the rate of checkpatch fixups should be
>> small these days.
>>
>> Acked-by: Laura Abbott <labbott@redhat.com>
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Greg, can you pls stuff this into your staging queue? Imo makes most
sense there.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
