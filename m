Return-Path: <hansverk@cisco.com>
X-Google-Smtp-Source: AIpwx4/9HNcfR/UwsOg20b47B1kYZ0WnLAAwOZeJGTLp8avK7dPU9tL3SAeoCoRbBUqFkEgJCKus
ARC-Seal: i=1; a=rsa-sha256; t=1524467999; cv=none;
        d=google.com; s=arc-20160816;
        b=BFMoZ681tDIKJX+dgf0mXHxpd28OdzSFmaxrCsk66HLMz+Eu5MqxlDpLcqrwt9Mm3a
         g2B9N0Guo9vPzvsgA4YhqAKag1c0pI+ZfQNh+tATpG84MTEWIp5XNL7Ao8T4isNMVnI9
         3QZYJAUV32Qf8HdeOE/hyYDYf8Vzk1zvlCCc0CSbmuPJ1HQ7Sp1xU6dfRzQXLS6di2Qr
         EBvORKvsKriUTVDShBeF9OfjM63hReKgmHeUY/f9Dp1j/JQI3T23yIQdgTZXz3N3S9xP
         Q1I3NfXX/5NUfnqZQETNhsfaYZ9LzR5eI/W8hFxHjlDk4gPoK8Rj6rlTBlwkClN/ObbV
         /uVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=0j+KdIhUUxwUq2w8s0VZ2+073ivduKhULXZFa+hTIbI=;
        b=UJVRzmkvCPIi2dJZlASTtDA/Y8BK8ZBZNwsq04Z15kFRWvAo9/dR1wbLjUYCgSU8b/
         ZQZhXkBgT6Om9E1gHa7DkTXXzHjr/cZSmU51687n14qK4dMQmUz7cSHEBiSxYdg9DnpV
         tjhINtrTmg35+NPQ1jF5wCv3bbM9hzIAMOO65udWf61+5iLu+qIfnBCHO4x2bF+9CGay
         ztfYQTSrTpxphergO9BUz+fWFDwbgbjQ/lnlfuzV0SW5wpDSiFMRXzbW3Z/77jkxFGNY
         KH0Z7paGUWh1yN99sIUgHf+t2FZwuuxdsaAEB3K1ekKnzGM9T4tbYcO310IiQw6CFBX2
         GzLA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=PUlwN+Ga;
       spf=pass (google.com: domain of hansverk@cisco.com designates 173.38.203.53 as permitted sender) smtp.mailfrom=hansverk@cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=PUlwN+Ga;
       spf=pass (google.com: domain of hansverk@cisco.com designates 173.38.203.53 as permitted sender) smtp.mailfrom=hansverk@cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
X-IronPort-AV: E=Sophos;i="5.49,317,1520899200";
   d="scan'208";a="3301215"
Subject: Re: [patch 4/9] LICENSES/GPL2.0: Add GPL-2.0-only/or-later as valid
 identifiers
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jonathan Corbet
 <corbet@lwn.net>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
References: <20180422220208.772527041@linutronix.de>
 <20180422220833.078058446@linutronix.de> <20180423065229.GD4208@kroah.com>
From: Hans Verkuil <hansverk@cisco.com>
Message-ID: <c2bd5d82-e443-418b-8d11-fad81e97b35f@cisco.com>
Date: Mon, 23 Apr 2018 09:19:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423065229.GD4208@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-User: hansverk
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598486097354490733?=
X-GMAIL-MSGID: =?utf-8?q?1598520556902663785?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 23/04/18 08:52, Greg Kroah-Hartman wrote:
> On Mon, Apr 23, 2018 at 12:02:12AM +0200, Thomas Gleixner wrote:
>> Quite some files have been flagged with the new GPL-2.0-only and
>> GPL-2.0-or-later identifiers which replace the original GPL-2.0 and
>> GPL-2.0+ identifiers in the SPDX license identifier specification, but the
>> identifiers are not mentioned as valid in the GPL-2.0 license file.
>>
>> Add them to make everything consistent again.
>>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Hans Verkuil <hans.verkuil@cisco.com>
>> Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> 
> As much as I dislike the "new" identifiers, I guess trying to hold them
> back is a pointless exercise :(

I like the new identifiers :-)

Reviewed-by: Hans Verkuil <hans.verkuil@cisco.com>

Regards,

	Hans

> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
