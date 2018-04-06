Return-Path: <greybus-dev-bounces@lists.linaro.org>
X-Google-Smtp-Source: AIpwx49IKO2Z/N3kWtzwbrVzU/Zt8x3st68Q4JkWvcLq23ZQGBgdEZPocNI9K6uA+lqa0SldFqED
ARC-Seal: i=1; a=rsa-sha256; t=1523030744; cv=none;
        d=google.com; s=arc-20160816;
        b=j42Y7FpqHV7gSHpE9AIlxXwLORDgeB7J/ahj63HdGipwVtx3F9/Ocv8YDAsx7tSeur
         hg4MAINK857eNQDywIhW24q9Z6gcxOak1gHjD5C5odvP1g3ydaiwPrC9bMxJ0W/iDRdR
         jX8NuMFCzy3Whg3Yuxf49/kzaMtAT4r1N6Sw8epx3PM8B63S/PrvwkEU/7XGzjV0XD/o
         vvbAWQXOS/mUwIXY8BfWRa7bdqVerD8a3D/cA2TNWuOzyD0X5NXSCpWpDoHwc9wqUM4o
         e1mVjLgdEn320tVVvSuE1E0PmOp99GNadZzl9/ma4eCivyoerqJOu3CG6MRSq9K0NlQq
         lHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:errors-to:content-transfer-encoding:list-subscribe:list-help
         :list-post:list-archive:list-unsubscribe:list-id:precedence:subject
         :cc:user-agent:organization:in-reply-to:content-disposition
         :mime-version:references:message-id:to:from:date:delivered-to
         :arc-authentication-results;
        bh=qmM5GekedCRDHLmGHLEcX7tITqUwcTsVFSx1rxeKONU=;
        b=1EzlFQ/B9DWhVMTHOEzXuQXjKzKMXxMIQZAgBMKHQNa+7Az/SykFJWTmuOvkcFAinq
         NSJTkSyKLNlCA+RuJa5S+Sohcd/iSEJvkFFuwRjrykcE/pBXth7nUkbTvbxIbyMA8Ilx
         mhWrzLobLiVQbdM3+K8gWZxgzbA4edBGKWnSrbAVvELYvIlg7cIonhtSS7jX+RSDFd99
         kNpw2qyZwJNvab33OXCVX54fGCx3+PAImChcDzyT8ssn6z32Borh3tzE55ZYSOFsMBag
         VEzhsEUkdrM5KvTFFRcT2GgGk3nF4WR/KaoVBq+ajR/Uj4uINOovuy0yERlxFdUsU0PD
         WEmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of greybus-dev-bounces@lists.linaro.org designates 54.197.127.237 as permitted sender) smtp.mailfrom=greybus-dev-bounces@lists.linaro.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of greybus-dev-bounces@lists.linaro.org designates 54.197.127.237 as permitted sender) smtp.mailfrom=greybus-dev-bounces@lists.linaro.org
X-ME-Sender: <xms:z5rHWuIH48G_R5nl2GyAE_bGXJsZUGGRYf6AJvkLKh511Of6Ns_qVg>
Date: Fri, 6 Apr 2018 09:05:34 -0700
From: Mark Greer <mgreer@animalcreek.com>
To: Gaurav Dhingra <gauravdhingra.gxyd@gmail.com>
Message-ID: <20180406160534.GC21252@animalcreek.com>
References: <20180406110922.GA14674@stallman>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180406110922.GA14674@stallman>
Organization: Animal Creek Technologies, Inc.
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: devel@driverdev.osuosl.org, elder@kernel.org, linux-kernel@vger.kernel.org,
 johan@kernel.org, greybus-dev@lists.linaro.org
Subject: Re: [greybus-dev] [PATCH v3] staging: greybus: Fix warning to limit
	chars per line
X-BeenThere: greybus-dev@lists.linaro.org
X-Mailman-Version: 2.1.16
List-Unsubscribe: <https://lists.linaro.org/mailman/options/greybus-dev>,
 <mailto:greybus-dev-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/greybus-dev/>
List-Post: <mailto:greybus-dev@lists.linaro.org>
List-Help: <mailto:greybus-dev-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/greybus-dev>,
 <mailto:greybus-dev-request@lists.linaro.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: greybus-dev-bounces@lists.linaro.org
Sender: "greybus-dev" <greybus-dev-bounces@lists.linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596994857938303702?=
X-GMAIL-MSGID: =?utf-8?q?1597013486263474008?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gRnJpLCBBcHIgMDYsIDIwMTggYXQgMDQ6Mzk6MjJQTSArMDUzMCwgR2F1cmF2IERoaW5ncmEg
d3JvdGU6Cj4gV3JhcCBjb21tZW50IHRvIGZpeCB3YXJuaW5nICJwcmVmZXIgYSBtYXhpbXVtIDc1
IGNoYXJzIHBlciBsaW5lIgo+IAo+IFNpZ25lZC1vZmYtYnk6IEdhdXJhdiBEaGluZ3JhIDxnYXVy
YXZkaGluZ3JhLmd4eWRAZ21haWwuY29tPgo+IC0tLQo+IENoYW5nZXMgaW4gdjI6Cj4gICAgIC0g
dXNlIGNvcnJlY3QgZm9ybWF0IGZvciBtdWx0aWxpbmUgY29tbWVudAo+IENoYW5nZXMgaW4gdjM6
Cj4gICAgIC0gaW5jbHVkZSBjb21taXQgbG9nCj4gLS0tCj4gIGRyaXZlcnMvc3RhZ2luZy9ncmV5
YnVzL2F1ZGlvX2NvZGVjLmggfCA1ICsrKystCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL2dy
ZXlidXMvYXVkaW9fY29kZWMuaCBiL2RyaXZlcnMvc3RhZ2luZy9ncmV5YnVzL2F1ZGlvX2NvZGVj
LmgKPiBpbmRleCBhMWQ1NDQwLi40ZWZkOGIzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvc3RhZ2lu
Zy9ncmV5YnVzL2F1ZGlvX2NvZGVjLmgKPiArKysgYi9kcml2ZXJzL3N0YWdpbmcvZ3JleWJ1cy9h
dWRpb19jb2RlYy5oCj4gQEAgLTIzLDcgKzIzLDEwIEBAIGVudW0gewo+ICAJTlVNX0NPREVDX0RB
SVMsCj4gIH07Cj4gIAo+IC0vKiBkZXZpY2VfdHlwZSBzaG91bGQgYmUgc2FtZSBhcyBkZWZpbmVk
IGluIGF1ZGlvLmggKEFuZHJvaWQgbWVkaWEgbGF5ZXIpICovCj4gKy8qCj4gKyAqIGRldmljZV90
eXBlIHNob3VsZCBiZSBzYW1lIGFzIGRlZmluZWQgaW4gYXVkaW8uaAo+ICsgKiAoQW5kcm9pZCBt
ZWRpYSBsYXllcikKPiArICovCj4gIGVudW0gewo+ICAJR0JBVURJT19ERVZJQ0VfTk9ORSAgICAg
ICAgICAgICAgICAgICAgID0gMHgwLAo+ICAJLyogcmVzZXJ2ZWQgYml0cyAqLwo+IC0tIAo+IDEu
OS4xCgpSZXZpZXdlZC1ieTogTWFyayBHcmVlciA8bWdyZWVyQGFuaW1hbGNyZWVrLmNvbT4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZ3JleWJ1cy1kZXYg
bWFpbGluZyBsaXN0CmdyZXlidXMtZGV2QGxpc3RzLmxpbmFyby5vcmcKaHR0cHM6Ly9saXN0cy5s
aW5hcm8ub3JnL21haWxtYW4vbGlzdGluZm8vZ3JleWJ1cy1kZXYK
