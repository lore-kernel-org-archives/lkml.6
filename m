Return-Path: <dave.hansen@intel.com>
X-Google-Smtp-Source: AB8JxZrQ+N9XcFlvxJBhb/iGMdYwTl7aLRQaRdZ/jmmBbyNA/kp4hffz6U0296W51Ca1aBvIe0OW
ARC-Seal: i=1; a=rsa-sha256; t=1525796755; cv=none;
        d=google.com; s=arc-20160816;
        b=RxgebgZxki7DRgIataGd/O4NABcz7rjvwEi55gt4bgiYvxEsKtYTbqNL194V21UYqv
         XqKVunv6w5tCXi6tqGMoM2/kVSCG4aVy8kqp3bHDB9By2797OQhWyDrAq8JHqYFK4OBG
         mS4iIU7MRtm+uT5JRBBfI+WPggaz8AO/YaNEgyu24fSVIFPlpVftAhRbmVFuhU3U3Js9
         EaHgAGdkEN24Wm1tlV8N/m9b9gB5cpfo4RNAozccuGpL2i7ufUMxB1neyZFG/FM5ySQn
         4SRSMhw3fV43f73K2bX1nOu+JWSoAvfUg06DC3MR/zHR5lPLyWuStdMcUc61o/wwPWx4
         yksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:openpgp:from:cc:references:to:subject
         :arc-authentication-results;
        bh=vFc1DXu/bHyGq7D3fbzryCsdmClNMX4TDb+GAgb/i0U=;
        b=U/D9yeRMF4x+6uqCxIqj7e63f4qA895rHc/hGwP8FBoBYeQsiGyZ1tabJAuo+gB3ku
         ocTgm71EdPL012zWoE1F4lnSiZCplf+4gcUJ1c5eac96MgW0KkZn2GOXugZ+A1yPAr/j
         gbrzlFFd/XDx2YIbpjX3yUk6YM3eh2OUySIBY7fzb0ZfSpM9/jpzuuywqWkjVdduhIJ5
         AbRsFhmWXXT5jt5nm1YbLK6H0Qyi+VAjvnwISuKZPxbf/33+tHsz7S5PQmYgbHKsGRTv
         IMGWdP29Rbuw57AwgqymD38DE+pr7ueb46s6Zr3jqr1TeljEEazni6wt+ds9kq/Nsuw0
         Tzbg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dave.hansen@intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=dave.hansen@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dave.hansen@intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=dave.hansen@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,379,1520924400";
   d="scan'208";a="39653095"
Subject: Re: [PATCH 1/2] tools/testing/selftests/x86: fix warning:
 "SEGV_PKUERR|SEGV_BNDERR" redefined
To: Li Zhijian <lizhijian@cn.fujitsu.com>, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
References: <1525770870-19067-1-git-send-email-lizhijian@cn.fujitsu.com>
Cc: mingo@kernel.org, tglx@linutronix.de, gregkh@linuxfoundation.org,
 pombredanne@nexb.com, ebiederm@xmission.com, luto@kernel.org,
 linux-kernel@vger.kernel.org, philip.li@intel.com,
 leist.fnst@cn.fujitsu.com, zhijianx.li@intel.com
From: Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Message-ID: <8f91739f-5d63-e6c9-7bf9-4c970237bcf8@intel.com>
Date: Tue, 8 May 2018 09:25:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525770870-19067-1-git-send-email-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599886734267032257?=
X-GMAIL-MSGID: =?utf-8?q?1599913858914150361?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/08/2018 02:14 AM, Li Zhijian wrote:
> SEGV_PKUERR and SEGV_BNDERR are defined since glibc-2.27


Acked-by: Dave Hansen <dave.hansen@intel.com>
