Return-Path: <igor.stoppa@huawei.com>
X-Google-Smtp-Source: AH8x227nn26cx1oGX0IT0rFsV3Xjuh5O6SXTNsiR77YdF4CgGPwtjF0ex6I0rpGLz0gXtg07QgHl
ARC-Seal: i=1; a=rsa-sha256; t=1517586570; cv=none;
        d=google.com; s=arc-20160816;
        b=v/02KTFJpWWmWwA5R02Dnc8DsliHCeMflz7kngjl7o7UzaYXDv8eK0I648NQe4oiSZ
         QA1kevkVYW2AWTEgxh0bUo0EgQn+EaLz/9yDl7o+Rd+4XmMBbmhAJt/HDtUhDMNGnpAh
         AHersGOqiERqs64jlVlSenr7toKAqMfoWpTs8sVRbA/JaSlW726LhBhRUd78rNoKccA+
         RBCVpb4q59lrtedAkusw7WeP7X8B5kG221GyWXpikCgvkptyhlAt33UM49JS9/sAZa5X
         io76tJDcISwkCavhH3HQKEHzPJ/jGQGj5s6SmJYUGwCDBt2Lbr5Zd20Lyw31PoLrspkF
         /C8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=TLXA9S3u6dvqRMiD1PIjzezJP0c1UY/OXejD96SMqow=;
        b=rnS1rjDONAMoaR7z1/uveQle1N0SgqNFCNiV44EtDHZkNuN4jYk60NR8KW7dd6hHA4
         aeZIK+DMEX15R0i1NzsdPV25yYy9jxA0VLdas3075kTAoGVpSjNHvOpahqFX16SA2co9
         T6YlHMu5iHp5WMEFWsQSScOnzAH1y+B0A0HBaW6eloeH6+UqFR9Yz/upYl7sUK8jgrDG
         wbFV/ZDtuOpI50ccneS/NeRE4qAzY1WFNBCOSZ3sjIKMP0m2OqjDVfVmQ/71C/irnsTS
         KZDEJskodj2xYp8X9eEK544AkKtLYj8pHlTK8fXYK+e2RvOFkKAvQ62ZZWI27cLZ54gD
         LIcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of igor.stoppa@huawei.com designates 194.213.3.17 as permitted sender) smtp.mailfrom=igor.stoppa@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of igor.stoppa@huawei.com designates 194.213.3.17 as permitted sender) smtp.mailfrom=igor.stoppa@huawei.com
Subject: Re: [PATCH v6] checkpatch.pl: Add SPDX license tag check
To: Rob Herring <robh@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, Joe Perches <joe@perches.com>, "Andy
 Whitcroft" <apw@canonical.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	"Philippe Ombredanne" <pombredanne@nexb.com>
References: <20180202154026.15298-1-robh@kernel.org>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <bb680231-b9ca-ee46-f088-086da0bed2c1@huawei.com>
Date: Fri, 2 Feb 2018 17:49:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180202154026.15298-1-robh@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591304287671259020?=
X-GMAIL-MSGID: =?utf-8?q?1591304855115044764?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/02/18 17:40, Rob Herring wrote:
> Add SPDX license tag check based on the rules defined in

Shouldn't it also check that the license is compatible?

[...]

> +				} elsif ($realfile =~ /\.rst$/) {
> +					$comment = '..';

What is the correct/acceptable license for documentation?
Creative Commons? AFAIK GPL is for source code.

Googling didn't bring the wished-for enlightenment.

--
igor
