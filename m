Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525314981; cv=none;
        d=google.com; s=arc-20160816;
        b=fuhIlkPzf93AGp6R7tjOt2LuAMys4yIRWOHl+ogRbmmeozYfSdqkee3rbfmqhwem0I
         ipUFNHG/KEIo+fnZ/exBiOrqwf5ds3r0I46kUZT4B3P6xMxfnp2ljgI6X+iKkdyxcM4z
         PTVSOfxo8apiApPrl4ibvMF/us9UfKsuf793CxL/GHxN3pHSdyW4a+ovbVVqvLwtH5A6
         sMg/Ca63/WJVRdKOpJ+b2CkIT+zOZ2Z1DHonFdLeBzFVnOZGAFo4YTeT2rGsDUavP9i7
         RCCTDw2kRgSxo5jWV0IR49yvLqAlMWtL6iXtY1WjqChaKgSVlI9IlrgFDvVqblOhidM+
         U/eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=iBcO1zy9G33s+wFCq3FFTgblnNYtT8SfciT1chIA4+I=;
        b=XOYMmIpJowU1x0jx4JRvqsB+GGbqu5fFBepTOHEs5gbMvvNZAvZR4EpvqbMZDQq/+i
         wHRTFVMN9gsCnDnoe8/ibnfm2YBeDAU+1HHQWcToDP1B9mL9sZ34yH4HHl+FUGrqQcG1
         TZ9fQOSsLU/n6PSNi11A9NaL0HERrAuQ20NvWqqaqgyW2AEjuuI4zDhz3k8ivQJ3tz5z
         CTqHAB49gw9GB7+CKz3E/7hwgjnFYREMf+gSkhM6K+GB6qXs5xMPZMqsmSCDrUri2tD1
         smqCiiiKw2YF9/TJ7Ssqk/4la2ZQFl04w8AXafXlwbSgM+zuRmOcbVuHWwASzHOdmOBY
         /4IA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=dAdrajm3;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=dAdrajm3;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AB8JxZpTt+c7E3THIsmVZSsTEEgTt6nYqo0Y25niYBiJ33vO/QOnawRv0QHKJAhYJGqtB8QKCtXKC96nljf/EAzYE3M=
MIME-Version: 1.0
References: <20180502154239.14013-1-christian.brauner@ubuntu.com> <20180502154239.14013-6-christian.brauner@ubuntu.com>
In-Reply-To: <20180502154239.14013-6-christian.brauner@ubuntu.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 03 May 2018 02:36:09 +0000
Message-ID: <CA+55aFyjTZi1S_R4434binJ4f_gkT-CAf8QpPzzVTj+ryi-K7g@mail.gmail.com>
Subject: Re: [PATCH 5/6 resend] statfs: add ST_SLAVE
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599367745879606462?=
X-GMAIL-MSGID: =?utf-8?q?1599408681877574234?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

No explanation, no nothing?

NAK.

              Linus
