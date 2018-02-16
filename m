Return-Path: <sathyanarayanan.kuppuswamy@linux.intel.com>
X-Google-Smtp-Source: AH8x227av0HBK2C23tMBfIfbwoPwauIfN13OcmLAM5RSSROmVrKgdsAadzmy8enRDmt13mDVVl5l
ARC-Seal: i=1; a=rsa-sha256; t=1518739381; cv=none;
        d=google.com; s=arc-20160816;
        b=zc45RAl9NQ1z/fhe165UVGmXNdneT9EFeXebtD+/bujoexLsQI/vg8eiNdvM43TRWu
         FsvrQ2/osH3snHMC9/9E6Ya/wFVt0zOMfC1zYFaMyat3HR86U+WC/depxfpDU6wuaDP7
         TFaDFJp8o5oOoafQlAKEtziem3Oz70Yq9EDVSsVpc/Ho0VVlzGuEmREM/xIvSIfbcm9z
         UJj6XIT1aPld7a4YLOZIi1rv59fy+o+eS2iuRXoQPoWrWIRSsiYh/MwX8uZx3pKavCKw
         Ew5pvzjxI+KwA8cu5fz+Du7l1cuf1lc5Uvi5Jfv9iuVZv7VesvHG2Kinf1t5qOs+sJ0d
         LiBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:reply-to:arc-authentication-results;
        bh=EloUTmZj49l/BhxnsntZwqB7s+irW6z+m8IZ8Pf/6ng=;
        b=p7QXKqvqVj5LC2EByyjrMd+Vb1oUi9FlbbjCU0fSkf1xg8Ld6Dxp6ck2pXJ8LmI9tn
         MoKjKDlS9CGtJr2jP2i/hHBOdpkbBGUWeKhnbbogiCxzrEuTrObRJG3OEc/yx2WzwFCB
         3m+jTmcCSxdO+jj5t5vj+/eYZW8mcLSYqrkCVFCDUDWVa0HCTxM9op43MIB2V9c8dKaa
         Z0+j3kcadmtfYe6pQrQnCBc9Yir4QdiLHVGnHpUrqxkJJt3YQrYUjJDKBjoI3nkvmKHr
         EYqB1Bsxr23f5dQHat5/yB+nQKqkVmWbK0DUCDUdnTDA/hc+AgaePLIp6EXtEWbDBH3C
         QJ9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of sathyanarayanan.kuppuswamy@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=sathyanarayanan.kuppuswamy@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of sathyanarayanan.kuppuswamy@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=sathyanarayanan.kuppuswamy@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,518,1511856000";
   d="scan'208";a="204644247"
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v1 1/1] usb: cdc_acm: prevent race at write to acm while
 system resumes
To: Greg KH <gregkh@linuxfoundation.org>,
 sathyanarayanan.kuppuswamy@linux.intel.com
Cc: oneukum@suse.com, felipe.balbi@intel.com, heikki.krogerus@intel.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dominik Bozek <dominikx.bozek@intel.com>,
 Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
References: <1518466503-36918-1-git-send-email-sathyanarayan.kuppuswamy@linux.intel.com>
 <20180215173720.GA12311@kroah.com>
From: sathyanarayanan kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <4d036ab4-1239-8afb-4eff-b4884006c326@linux.intel.com>
Date: Thu, 15 Feb 2018 16:03:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180215173720.GA12311@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592227538406824462?=
X-GMAIL-MSGID: =?utf-8?q?1592513666258626379?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,


On 02/15/2018 09:37 AM, Greg KH wrote:
> Why hasn't the author of this patch signed off on it?
This patch has been initially submitted with Gerrit-ID and some custom 
tags. During the scrubbing process of this unrelated details, I think 
the automated script accidentally deleted the signed-off tag. Let me 
confirm it with author and get back to you. Mostly I will submit a v2 
with proper sign-off info.

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer
