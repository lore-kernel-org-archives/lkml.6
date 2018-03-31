Return-Path: <dhowells@redhat.com>
X-Google-Smtp-Source: AIpwx48I2x+irIKJfFvn5jE0wYjrgE+uqelHHS+cgZ9w6fAnklSssAImK1TPBzlNVT5PGpGeHtMX
ARC-Seal: i=1; a=rsa-sha256; t=1522491604; cv=none;
        d=google.com; s=arc-20160816;
        b=uEhVGxbm/KFo3kz+L/K3ztZOeWZEgTwBlSv1TnAv0qtlbMXLcgG9U8CbAZUq0vjPBx
         2weO/vFPnLzoMQAJ0PKXFZn04sb24xj6OyQcbueddiflVPJtRWKAnbOMffHMfwkwjS3x
         bXSpOob1pJmzQTeC0lMTUrTNXh66BUNkGJoS+xibJkw2YLG0+83+2UymiE74ODLw5SHO
         Z25mxeXYR0Kb26q6XX8ZKqQERgtLvuYKjX1XKzk6Lj9Obf7tdAkJDeliQAMvWMq/rgkz
         nRuCf0h+hMILhtzPph2+rwJTk5hwaVILThOyaNWb7BHZbMpDkQ2ZnJ8tuEDeOBMkbm/J
         6KoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:content-id:mime-version:subject:cc:to:references
         :in-reply-to:from:organization:arc-authentication-results;
        bh=Vrrm5xgkMMh6OJ7ytyPSxr9VP/C2vhTbpDhq+V91k+M=;
        b=A5COg1w5HFpSmzU/lq2Y7n6RN1xR5Rw3xHFxnBav2XVbICkZ4KFwBp1rw4wcEBoNNl
         T5tF2gpLIWmbnc+7BsJ1EkPr/hRYmM7Mo/Wb9Bo/WL26IGuGAMVtXWV3akbykKBV75xg
         BVxlqffkNUSccqJ6K6yNFZ8NAwnn/51Ap983VBJsvIErAwuUtRG9XEQOJUaNg0Vt9m3L
         XyuebL6CBUAJMHj6ekleKTULcBXHu6blw6eTz0sDEX9ZGTEs8CPK7mjtILdOf3tjg8Kc
         RwKzL3uU2KwitywKdV1z+Azqi4iUp7gBvtas5+Wfx5ltRkcxXIttalYukyNwrppez+NU
         z0dg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dhowells@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=dhowells@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dhowells@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=dhowells@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <alpine.LRH.2.21.1803311145180.7769@namei.org>
References: <alpine.LRH.2.21.1803311145180.7769@namei.org> <4136.1522452584@warthog.procyon.org.uk>
To: James Morris <jmorris@namei.org>
Cc: dhowells@redhat.com, gnomes@lxorguk.ukuu.org.uk,
    linux-efi@vger.kernel.org, mjg59@google.com,
    gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
    jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
    linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17791.1522491600.1@warthog.procyon.org.uk>
Date: Sat, 31 Mar 2018 11:20:00 +0100
Message-ID: <17792.1522491600@warthog.procyon.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596407243846270411?=
X-GMAIL-MSGID: =?utf-8?q?1596448156703798440?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

James Morris <jmorris@namei.org> wrote:

> Are there any known coverage gaps now?

I've covered all the ones I know about.

David
