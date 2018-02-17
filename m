Return-Path: <ed.cashin@acm.org>
X-Google-Smtp-Source: AH8x225UEtCgq7IxRJFNi4dybr7mlqOPl14g05HofRK+Hc1Zk0XiTPJmLmcEeKi9TGW7VVSHfDSz
ARC-Seal: i=1; a=rsa-sha256; t=1518836299; cv=none;
        d=google.com; s=arc-20160816;
        b=0CghNZNuC9nUtBlp+Or+yOwA3/2a58jw/OJEXQDSTUY6vfO8rc90Es3tCaudc7rvt2
         kLr901E9oALEYYDmyefHFWJv9fy9tLZ1uAjxn+XpNB8Gn2n0QIQbJiEcTCfdAv1phRAV
         pSSkMQIGWK7xR5Cplf4WLvnnStJvQykaOCRHeRGVz/Hn4MKIO0U5wM+MGd4/ZpdYvFHQ
         a3+ebS1UoF/dJcOFy7eu9Rs8SqC3an8gyiNGONe/J4SgQeSVdELMiPQLtBY2jEfWGWv0
         V72km15SWes1SPNYbHbmd9xpLiAezcRO9iTU7AH3d0GZiwjYQ1yJBAub5kUUMVkEczp6
         hksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=/u7LqPpEKwz8d0XJOkHggRLLggBla/VfiM20iFCvCJM=;
        b=iUVg1JSjjTWKxWIX7LZSy/jYKSV9tNTjAjybuGK2Ck4ZBEKWwtPtRMD7tO+A3asnsx
         zk7BGvz+TN/8JAJm4aES5NfW8gkidCn0peUE74SVowX4R6DzgF2Cad9DZcDxTGEZUw88
         BGjpI+opY8Air4C1EgeynWxjRlas2a8eIIrfT8NIJbTZ2ehZCpLAhclgpfl7zB28Bjkn
         dNTvsRov0YrH49R6NJiwIOKsF4f93kSj2oPENlmfEmX9QY2RMSjH5rB9lRtOGc/FJX2z
         Z8bvbjh2UwSOCKkQf3Iyt37+OTILbhmBlyedeUqN6VQFrqlx65jurqaQhqPQUGnjA1TY
         gRuw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning ed.cashin@acm.org does not designate 69.89.23.12 as permitted sender) smtp.mailfrom=ed.cashin@acm.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning ed.cashin@acm.org does not designate 69.89.23.12 as permitted sender) smtp.mailfrom=ed.cashin@acm.org
X-Authority-Analysis: v=2.2 cv=G85sK5s5 c=1 sm=1 tr=0
 a=6lV6tj8ir7tGSl/9xQZNPA==:117 a=6lV6tj8ir7tGSl/9xQZNPA==:17
 a=IkcTkHD0fZMA:10 a=Op4juWPpsa0A:10 a=6dSziLGFmYxQ7E99zKgA:9 a=QEXdDO2ut3YA:10
Subject: Re: [PATCH] aoe: document sysfs interface
To: Aishwarya Pant <aishpant@gmail.com>, linux-kernel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
References: <20180216153900.GA12832@mordor.localdomain>
From: Ed Cashin <ed.cashin@acm.org>
Message-ID: <9ddc04c5-eedf-b88a-0cea-bd0c91a2dfcc@acm.org>
Date: Fri, 16 Feb 2018 21:58:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180216153900.GA12832@mordor.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box320.bluehost.com
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - acm.org
X-BWhitelist: no
X-Source-IP: 24.99.197.19
X-Exim-ID: 1emshb-0037GQ-Fj
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-24-99-197-19.hsd1.ga.comcast.net ([10.0.0.86]) [24.99.197.19]:59801
X-Source-Auth: nobody
X-Email-Count: 0
X-Source-Cap: bm9ib2R5Oztib3gzMjAuYmx1ZWhvc3QuY29t
X-Local-Domain: no
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592572558446163401?=
X-GMAIL-MSGID: =?utf-8?q?1592615291670839573?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/16/2018 10:39 AM, Aishwarya Pant wrote:
> Documentation has been compiled from git commit logs and descriptions in
> Documentation/aoe/aoe.txt. This should be useful for scripting and
> tracking changes in the ABI.
...
> +What:		/sys/block/etherd*/netif
...
> +Description:
> +		(RO) The name of the network interface on the localhost through
> +		which we are communicating with the remote AoE device.

I'd recommend changing that to, "network interfaces".

Thanks!

-- 
   Ed
