Return-Path: <mchehab@smtp.s-opensource.com>
X-Google-Smtp-Source: AB8JxZoe+F+p9d/GFEK1mY7aHM0bLK2QorWevchfgDXdW8+3KHfwsh0iUTuFr4tFKeyBTq7TRifr
ARC-Seal: i=1; a=rsa-sha256; t=1525871952; cv=none;
        d=google.com; s=arc-20160816;
        b=YfQEgu7GldiAcIaVnkt45kVEHnzY11wcKQwDVWuEyyyAQlxxSPnm69VRaO5brkwScD
         kJGIcTs6eeA4CDT+KBWH/3aT12pI1QsjKJfPZEIaI8eU6kdEeL/dNSnvlytwOE6xrVrM
         e/DNy9vYS2ZC/bL8p0/NBUFCKzrYyWg4wZSN9QHlKvIKGLrwt9CAZ/cVcDutcZM8OUXm
         6CobsJguQpEJxZVDdgrDrVLVmJnCobASjfi+WjR/xPn6XRXGPnqZWugTApW8oZIOPV5S
         fDuNbKGH27H5utBr2oO4KmvQErsrrDyq9c4SjDfI4/jHqewoakdxvzeyyVd3UHgNdoqH
         MC9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:references:in-reply-to:references:in-reply-to:message-id
         :date:subject:cc:to:from:arc-authentication-results;
        bh=7nvR6SM1qoeJQqNneeZWpxcam4zSkmAOTGZK2F8rdUE=;
        b=kqPEHXd0gCN4w72Q310QuedglRYke0IENipdaEJzSl8PLJV8LmImeKZlHmGX5Mhv1t
         JuDwt4oTvA5uRnQPFD93yFM+LXy1c9JVzMAGhjfEWTbWqg+9pS1IylLlNIWaU2iF6FHH
         iZVAPf0Z4v+T5zWBsHkBFoxO6X3+MtA+CWdfjO5kU53jn/i8mDJbSM1oXh7iweZv+BiF
         KRVzSooekHCIsFaxqDuFe3tk2DBq6AJYjLUgvTDvdqPKC0x4YD4eDaVtPFvhsMBJVJIj
         tnmgvulNY5ULj3tnDZPtPogMi5Alqr0wssM/rLc1s0Ha3EFjTNmzAGTcOAvhjW6zw2S1
         QveA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 64.30.133.232 is neither permitted nor denied by best guess record for domain of mchehab@smtp.s-opensource.com) smtp.mailfrom=mchehab@smtp.s-opensource.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 64.30.133.232 is neither permitted nor denied by best guess record for domain of mchehab@smtp.s-opensource.com) smtp.mailfrom=mchehab@smtp.s-opensource.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 05/11] docs: uio-howto.rst: use a code block to solve a warning
Date: Wed,  9 May 2018 10:18:48 -0300
Message-Id: <4093cc9c8d981c3a5d810c22d7366b70164c61b3.1525870886.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525870886.git.mchehab+samsung@kernel.org>
References: <cover.1525870886.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1525870886.git.mchehab+samsung@kernel.org>
References: <cover.1525870886.git.mchehab+samsung@kernel.org>
Sender: Mauro Carvalho Chehab <mchehab@smtp.s-opensource.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599992708463086993?=
X-GMAIL-MSGID: =?utf-8?q?1599992708463086993?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

/devel/v4l/docs/Documentation/driver-api/uio-howto.rst:715: WARNING: Unexpected indentation.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/driver-api/uio-howto.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/uio-howto.rst b/Documentation/driver-api/uio-howto.rst
index 92056c20e070..fb2eb73be4a3 100644
--- a/Documentation/driver-api/uio-howto.rst
+++ b/Documentation/driver-api/uio-howto.rst
@@ -711,7 +711,8 @@ The vmbus device regions are mapped into uio device resources:
 
 If a subchannel is created by a request to host, then the uio_hv_generic
 device driver will create a sysfs binary file for the per-channel ring buffer.
-For example:
+For example::
+
 	/sys/bus/vmbus/devices/3811fe4d-0fa0-4b62-981a-74fc1084c757/channels/21/ring
 
 Further information
-- 
2.17.0
