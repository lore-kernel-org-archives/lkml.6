Return-Path: <mchehab@smtp.s-opensource.com>
X-Google-Smtp-Source: AB8JxZqngZTWvzUQD+le8FH5R82IwUlUifD2EH6ID/kZXiiw7Sup0paHBx8HmO9F0l9bE0w/ZkYV
ARC-Seal: i=1; a=rsa-sha256; t=1525685770; cv=none;
        d=google.com; s=arc-20160816;
        b=GzML+dq2NnX4wjUuTf0VMGiQbHTQidem/YOH75s9hXlm+Dh63+yHXCd+3JkeWDAISB
         SVqWdnAtjyRpN+S2jZOCOJ78HLvQYGXLpCe90VuQBEJip+lt0Yl1002Onu4ovzWojjyj
         glumUX0/GrP6BsQYT84MHkuFikv2BZ+I0UDUkmZKd3WXE90N9Xi5o0Y6aSAQo3POJ0Pr
         YyhrA9vpCy9EScPAoO5BUENF5a8w43CEmB7NM5JVY6wklTg8foAizsec1S0pryuFLBau
         tZIJ+NMCVZGqOD11b5QsdjGYn56duz+vImNCqIPx3FNILd8eaFrFFlhJTGJCxeuRjZFB
         ywPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:references:in-reply-to:references:in-reply-to:message-id
         :date:subject:cc:to:from:arc-authentication-results;
        bh=7nvR6SM1qoeJQqNneeZWpxcam4zSkmAOTGZK2F8rdUE=;
        b=zNX0H9MWuAXhgeFLL5dbX9Fp03tTZ7JhJYfwSnmaSmH9F+rUYBuqOHx86h0RwjnAnw
         mfvRXDEd70l9iTJNvQHOOQldqWYh2mAT43xoNgoeq6toNBTHi7f/f+HH5QrigcpRsf89
         nmBM+rMyiuey/IQMPWRTkZdd7pV/a9rpX7nN6033KXdFsdMg0MLEycvgCAIpRI75WJ7O
         ARRrH2Yw47SvQ7Kf4GAkWX24ESVJ89oFCy2e7Mtf9XUYJwM/2WYlNOIdEn8MdFh+XeBn
         cLB3r19pNA0lN81DKhds67X9pyeD13C7o2UPTjRMFoKmGA3CBHdHqZIby8wIyx8JfLz3
         CimA==
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
Subject: [PATCH 17/18] docs: uio-howto.rst: use a code block to solve a warning
Date: Mon,  7 May 2018 06:35:53 -0300
Message-Id: <65bca40bfd11c80cd13224f2e4309ff4f1ad05aa.1525684985.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525684985.git.mchehab+samsung@kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1525684985.git.mchehab+samsung@kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
Sender: Mauro Carvalho Chehab <mchehab@smtp.s-opensource.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599797482391460903?=
X-GMAIL-MSGID: =?utf-8?q?1599797482391460903?=
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
