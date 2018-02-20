Return-Path: <ed.cashin@acm.org>
X-Google-Smtp-Source: AH8x226XPnPaZQa+PvNOJa1DJm48j0UIRxLBDkuuywk0qp6CqhzJiG5dsOZ3WWzT5fFg0Sqgvz1M
ARC-Seal: i=1; a=rsa-sha256; t=1519092524; cv=none;
        d=google.com; s=arc-20160816;
        b=MY33dug8R6Ao0z2XwBfWQR8QbrBaOwLBqKo/bOMjD5HVTmP8lQTRHPcBMX3Oges1Aa
         Wf8XOD2KoPWrsKKjNcJbtatIqPm3Ow2Eoyd/UL5UeaUkxTUMIMcTQfeDon/mNucsbrpC
         ygRkPoxeMyf9zGSl+fnRp1t/IK22kVQD5z/Mh80XBX9znJ4EkXPy1uOVh4/cL99xEIdM
         CMYZdWi2DArAuysHa8U+Y/mknpgPV1u1mijRB7etws7rB3blSDzrHk55Vx732+B8RLQR
         q4kokvC5zCjZvdnx6AWDnESc7B6KKXoUL75O/VJTL6B+eanDqwgOhWpUIJWNxxLQ4byL
         Vziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=83TGgaRZ9QwMmDICDH3h+jRF67kDZvbF+dfPZbK9WLY=;
        b=N5ioM97KO6ycXxrGXYgnLltyEOipwSlvXnNYr+wO/inhw2tC+k0BiLGgkaHi0kGo3f
         eSi2YEXwGqvpRJNrfmNRZi6lVNaLP1Eh9F9JnVLvWW9k4KZNwTO11yHElIPO4TyN08dm
         BZ9tOGrS/3uBpE8hKNr5Lu3zXBwD+cqI7AyELLir9HJzbA9hd40cqLmciLSUZGDpet6j
         dvKu7djv/ulUp7h8pG9dLKYrX7110QJsflkCVsTnSaz/9hwwAr46iC+TlLTZvQD6NGMn
         EwsxMFbpcRXCy9uJ92heU2Yl8QXfiudBb4ad7tu7AWuOgJDBlNymEXYPXZ3S9YER96d5
         zg1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning ed.cashin@acm.org does not designate 173.254.64.10 as permitted sender) smtp.mailfrom=ed.cashin@acm.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning ed.cashin@acm.org does not designate 173.254.64.10 as permitted sender) smtp.mailfrom=ed.cashin@acm.org
X-Authority-Analysis: v=2.2 cv=TIA1cxta c=1 sm=1 tr=0
 a=6lV6tj8ir7tGSl/9xQZNPA==:117 a=6lV6tj8ir7tGSl/9xQZNPA==:17
 a=IkcTkHD0fZMA:10 a=Op4juWPpsa0A:10 a=6dSziLGFmYxQ7E99zKgA:9 a=QEXdDO2ut3YA:10
Subject: Re: [PATCH v3] aoe: document sysfs interface
To: Aishwarya Pant <aishpant@gmail.com>, linux-kernel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
References: <20180219181653.GA2925@mordor.localdomain>
From: Ed Cashin <ed.cashin@acm.org>
Message-ID: <2a0a129e-eb85-8fc5-3df4-c8a855a0b48f@acm.org>
Date: Mon, 19 Feb 2018 21:08:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180219181653.GA2925@mordor.localdomain>
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
X-Exim-ID: 1enxME-001Qxz-Fg
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-24-99-197-19.hsd1.ga.comcast.net ([10.0.0.86]) [24.99.197.19]:33033
X-Source-Auth: nobody
X-Email-Count: 0
X-Source-Cap: bm9ib2R5Oztib3gzMjAuYmx1ZWhvc3QuY29t
X-Local-Domain: no
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592854282679037569?=
X-GMAIL-MSGID: =?utf-8?q?1592883963300924351?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/19/2018 01:16 PM, Aishwarya Pant wrote:
> Documentation has been compiled from git commit logs and descriptions in
> Documentation/aoe/aoe.txt. This should be useful for scripting and
> tracking changes in the ABI.

I don't see any problems with v3.  Thank you.

-- 
   Ed
