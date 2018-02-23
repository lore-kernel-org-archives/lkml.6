Return-Path: <corbet@lwn.net>
X-Google-Smtp-Source: AH8x227GUWb1s89n4N3iSAUsYHfkyL4O8t/zZpxgil6cy8X6xKWaeuE6lXqJIrkQI27CNNFZBFhI
ARC-Seal: i=1; a=rsa-sha256; t=1519398795; cv=none;
        d=google.com; s=arc-20160816;
        b=vs6Ccj6+yR8YZhNcxxnAdDuvQCQA3dtsOCEYScT3Er70OHBOBIdbOf1Dwv2FCZu3Hd
         1IzW/zuIu/Kp77uEG/0Nv+C74rRaSlkLHrYROqQeqJ3jEw9XuGhc7lBEU93mWKfBNE0O
         yeQol1EE8GT33ECq6htN4xehxMd8y33XhoT3osFewxm7fIRSpmz3+vEzxVOSP4WEoDV6
         EndD88G2MgKhGx/BLyEfPYQkKa3BfQOpyBeJMhkxODtdD1YYRPpo7q7stSRxrVzhvly4
         95bHNGBeAwkKMj+8yQR34YOvcPECq3oUZkxYILvKgofr0KVU73+kKrb7i3LGJfmPVk5x
         v2nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=9nQkyJ063oi5I8yNz7XomuXO5ynbX4c1cj6u5ODZ87M=;
        b=aXIPVlYC7PqJ3Jwy8IcrTg9D22+llq1MkkdRNGhXO2NeIKafoFI9pAP13hvK00prvW
         PqhFv/t9D4YLwCgsAmpQ7G1o5UydozfG78c3VeDU7pxril4K0kZ050qpCjc9SWQt8XdU
         T7pM7ogl+rJTSvJVoTbo4QJEwqFPMZ38JPEw5CCrzEYmsFOtvoC6MRlIP4lDaDvRxODo
         /kbc4jnbauNklTymCpqGAxZCKBcG3JohlzT+BhNuGYfLkh2sC+7WjIzLURRLwt0jrvVB
         0rqixtNfheTfzTFwAU7etKdxeVKZsVwOzCwh8KvSXnIng5Up+DsVsQj6YcbK/8rNCnQb
         SC7w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Date: Fri, 23 Feb 2018 08:13:13 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Aishwarya Pant <aishpant@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, Greg KH
 <gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [RESEND PATCH v2] Documentation/ABI: clean up
 sysfs-class-pktcdvd
Message-ID: <20180223081313.688cd1eb@lwn.net>
In-Reply-To: <20180223131632.GA21867@mordor.localdomain>
References: <20180223131632.GA21867@mordor.localdomain>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593197774356284506?=
X-GMAIL-MSGID: =?utf-8?q?1593205110890984334?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Feb 2018 18:46:32 +0530
Aishwarya Pant <aishpant@gmail.com> wrote:

> Clean up the sysfs documentation such that it is in the same format as
> described in Documentation/ABI/README. Mainly, the patch moves the
> attribute names to the 'What:' field. This might be useful for scripting
> and tracking changes in the ABI.
> 
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>

Applied to the docs tree, thanks.

In general, I've been setting aside the sysfs ABI doc patches to see what
the reaction is to them.  I'm trying to catch up with the ones that
haven't been merged via another tree, but it wouldn't be entirely
surprising if I miss one.  Please don't hesitate to resend anything that
doesn't appear in linux-next in the near future.

Thanks,

jon
