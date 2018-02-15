Return-Path: <axboe@kernel.dk>
ARC-Seal: i=1; a=rsa-sha256; t=1518668906; cv=none;
        d=google.com; s=arc-20160816;
        b=CbJhiMb1Em8PpR0DpaXHHH+deb+HYzDagTbBgk/7NsgpKCSwEGQyY20kIO+ZScfpUy
         JKRYxENWE2kdIOf77xFpLesRdu2sJWWyXHxlSDUYTKZljO4IqTh+FcKabysn1xfyCV2j
         huqRR5JCSoBAF/35iCt00CmI2FD3S4A8YlivQCocQ/dzH9IN37DUtYusGHd54N/Z18la
         SbTXG8uJw65kpDbyiN/2Z70GPXTktwfIcg3c14TITTm7apexNxAxZC6QwL27mcX0GJuB
         OmeoX/cmIhZG/4QKG0mOWcqcy/r4SSqjIWzjgNORr2u2cGqB5jGBKBIRXtb+k1c6J7zq
         lDdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :dkim-signature:arc-authentication-results;
        bh=mmkTOvuV5jq3iRlP/WisDi6+jmzSrCRfzbQkJ7tetkU=;
        b=PnECYsJiNhJan3iV12kFmATJU456M76t2DX+l6AjEv1PfQz/uA0OkV0A+SLBzcrsuf
         0N77CuWCleNl5iCfMJP2lQgRUc1m0uDLM5y7subAX59exEg7ueq2spbkv3XxLe8I4QzR
         GXJcMovQhBeYISWgP70LS+y0vfV8Fj9ukdhleF7wtgIlZ97rf8zg3ZM4hOOSHpAd6Ybj
         Wgk/+58VSySyeh/iTt+LqZoQ52gYtvbg42J2uJR7PDY2KPPRTftwc1M55EZ8d8Ft6j2g
         HG9MA0TlpqpK8eDOTuZK59X8YGC/3mYFmGlOtXWbYPzQdzNwappgeZurN9nzQTwW+Rqr
         mNlg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel-dk.20150623.gappssmtp.com header.s=20150623 header.b=JXTZjiAB;
       spf=pass (google.com: domain of axboe@kernel.dk designates 209.85.220.41 as permitted sender) smtp.mailfrom=axboe@kernel.dk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel-dk.20150623.gappssmtp.com header.s=20150623 header.b=JXTZjiAB;
       spf=pass (google.com: domain of axboe@kernel.dk designates 209.85.220.41 as permitted sender) smtp.mailfrom=axboe@kernel.dk
X-Google-Smtp-Source: AH8x227PYbtZnc116IA4TDaVMvlVEaWWod1lbnl9yJIeGvF+co2wb8E7jJf96sQDzfLV493Lk1w/bw==
Subject: Re: [PATCH V2] lib/scatterlist: Add SG_CHAIN and SG_END macros for
 LSB encodings
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 bart.vanassche@wdc.com, jthumshirn@suse.de, chris@chris-wilson.co.uk,
 tvrtko.ursulin@intel.com
References: <20180215033356.6978-1-khandual@linux.vnet.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d5fdd94f-5432-65b3-dfad-b81e4283780c@kernel.dk>
Date: Wed, 14 Feb 2018 21:28:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20180215033356.6978-1-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592436393983047782?=
X-GMAIL-MSGID: =?utf-8?q?1592439766853042568?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2/14/18 8:33 PM, Anshuman Khandual wrote:
> This replaces scatterlist->page_link LSB encodings with SG_CHAIN and
> SG_END definitions without any functional change.

Looks good to me, I'll add it for 4.17.

-- 
Jens Axboe
