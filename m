Return-Path: <greybus-dev-bounces@lists.linaro.org>
X-Google-Smtp-Source: AIpwx48F/5MoMbKBjpqIeCYtvxDLcOPOT7qNLv3o5ZCkHCJ2MK3ZgBr0HI/EKmVlFqLY8SjmH/UI
ARC-Seal: i=1; a=rsa-sha256; t=1523010941; cv=none;
        d=google.com; s=arc-20160816;
        b=YooM3sIXyxjWPt3yWuFUS993n2pwdZ+/seX1EHJInQlW5YCPDiQLd9ltRJiKAHCzlH
         3+1JUyQQ4yypw7riGZC1KByU0RvjKJRTsGdMA47QA4JXJIirft3YzJ2YGBRvZlbMa2m9
         a1ysikpisK4BOJxrHma/kJjbaWhvhdXUcJ+jHfV5EBwXmr4W5/CTBlWEzBkdBRtztRu+
         mxibDkGwJQCUN6Up+sdoWUnZBLnbWQXwEgxgc/hRweQX0OqzUqSMsObWFpxboiosVO4l
         +r1hn68wTCPmS8k3uiw5qEaup2oKo5CiW5gO2qLXBxWnZulsl4Nc+MidO2HMPJ0JWfrU
         c5lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:errors-to:content-transfer-encoding:list-subscribe:list-help
         :list-post:list-archive:list-unsubscribe:list-id:precedence:subject
         :cc:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:to:from:date:delivered-to
         :arc-authentication-results;
        bh=Vtlnq9kBcL9PUNhTiZORbtRO0xunKJ8e67bzDhDAiug=;
        b=I7nmbTuUZinUj5qZn4gcZgvx69Kcrp1QqfzPa4b8/xQY5qLaXUq1o1EqYoZApa9o1K
         2s799hWrv93zhEcqAwobhiRDDWlohgUkapGzrc1hybE+prdg086tTaDX/OTRrl+tLsMW
         58Gka2hXMehjXmVuw1JyovOk9EOObp2FVZQqHGCoVJQyLLgaH/NhqKQZzbxN75qoSY3H
         jmH/HZe8OVRWlBW1whkf6rg5JkU1sQNACFJ1MQ8IcxBwfZ7Ofvr8G4bGCTfCGrVjLq2/
         Gee7wjZMY0C2aoBHXRNc1tR2H+098okd0/pzwCpjg9b0Wbm3FPz5TdVdQAmO2Ef/bWc6
         Ecnw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of greybus-dev-bounces@lists.linaro.org designates 54.197.127.237 as permitted sender) smtp.mailfrom=greybus-dev-bounces@lists.linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of greybus-dev-bounces@lists.linaro.org designates 54.197.127.237 as permitted sender) smtp.mailfrom=greybus-dev-bounces@lists.linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Date: Fri, 6 Apr 2018 16:05:32 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Gaurav Dhingra <gauravdhingra.gxyd@gmail.com>
Message-ID: <20180406103532.GA3572@vireshk-i7>
References: <20180406100953.GA12400@stallman>
 <CAOh2x==TphhhoPVSFdFmFCQr4Ag_+tMzOOW3yp-e++SQcrWggA@mail.gmail.com>
 <1bb8c642-a2ba-0c8c-cab9-b4ea408eeedb@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1bb8c642-a2ba-0c8c-cab9-b4ea408eeedb@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: driver-dev <devel@driverdev.osuosl.org>, Alex Elder <elder@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Johan Hovold <johan@kernel.org>, greybus-dev@lists.linaro.org
Subject: Re: [greybus-dev] [PATCH v2] staging: greybus: Fix warning to limit
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
X-GMAIL-THRID: =?utf-8?q?1596750959468280779?=
X-GMAIL-MSGID: =?utf-8?q?1596992721104398628?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gMDYtMDQtMTgsIDE2OjAyLCBHYXVyYXYgRGhpbmdyYSB3cm90ZToKPiBJIGRpZG4ndCByZWFs
aXplIHRoYXQgaXQgd291bGQgYmUgbmVjZXNzYXJ5IHRvIGFkZCBpdCB0byB0aGlzIHBhdGNoIHNl
dC4gSQo+IHRob3VnaHQgeW91IGd1eXMgd2lsbCBkbyBzcXVhc2hpbmcgb2YgdGhlIGNvbW1pdHMg
KHYyIGFuZCB2MSkgYW5kIHVzaW5nIGp1c3QKPiBvbmUgY29tbWl0IG1lc3NhZ2UgKGFuZCB3aWxs
IHRha2UgaXQgZnJvbSBsYXN0IGNvbW1pdCksIHNlZW1zIGxpa2UgSSB3YXMKPiB3cm9uZy4gTm93
IEkndmUgdW5kZXJzdG9vZCBpdC4KCjopCgpXaGVuIHlvdSBzZW5kIFYyLCBpdCBkb2Vzbid0IGhh
dmUgYW55IGRlcGVuZGVuY3kgb24gVjEgYW5kIFYxIGlzCmRpc2NhcmRlZCBhZnRlciB0aGF0IHBv
aW50LiBWMiBpcyB0aGUgZnVsbCBwYXRjaCB3aGljaCBzaG91bGQgYmUKYXBwbGllZCBhbG9uZSwg
d2UgbWVudGlvbiBWMiBpbiBzdWJqZWN0IHNvIHRoYXQgaXQgaXMgZWFzaWVyIHRvIHRyYWNrCnRo
ZSB2ZXJzaW9ucy4KCj4gPj5TaWduZWQtb2ZmLWJ5OiBHYXVyYXYgRGhpbmdyYSA8Z2F1cmF2ZGhp
bmdyYS5neHlkQGdtYWlsLmNvbT4KPiA+Pi0tLQo+ID4+Q2hhbmdlcyBpbiB2MjoKPiA+PiAgICAg
LSB1c2UgY29ycmVjdCBmb3JtYXQgZm9yIG11bHRpbGluZSBjb21tZW50Cj4gPj4tLS0KPiA+PiAg
ZHJpdmVycy9zdGFnaW5nL2dyZXlidXMvYXVkaW9fY29kZWMuaCB8IDUgKysrKy0KPiA+PiAgMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4+Cj4gPj5kaWZm
IC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL2dyZXlidXMvYXVkaW9fY29kZWMuaCBiL2RyaXZlcnMv
c3RhZ2luZy9ncmV5YnVzL2F1ZGlvX2NvZGVjLmgKPiA+PmluZGV4IGExZDU0NDAuLjRlZmQ4YjMg
MTAwNjQ0Cj4gPj4tLS0gYS9kcml2ZXJzL3N0YWdpbmcvZ3JleWJ1cy9hdWRpb19jb2RlYy5oCj4g
Pj4rKysgYi9kcml2ZXJzL3N0YWdpbmcvZ3JleWJ1cy9hdWRpb19jb2RlYy5oCj4gPj5AQCAtMjMs
NyArMjMsMTAgQEAgZW51bSB7Cj4gPj4gICAgICAgICBOVU1fQ09ERUNfREFJUywKPiA+PiAgfTsK
PiA+Pgo+ID4+LS8qIGRldmljZV90eXBlIHNob3VsZCBiZSBzYW1lIGFzIGRlZmluZWQgaW4gYXVk
aW8uaCAoQW5kcm9pZCBtZWRpYSBsYXllcikgKi8KPiA+PisvKgo+ID4+KyAqIGRldmljZV90eXBl
IHNob3VsZCBiZSBzYW1lIGFzIGRlZmluZWQgaW4gYXVkaW8uaAo+ID4+KyAqIChBbmRyb2lkIG1l
ZGlhIGxheWVyKQo+ID4+KyAqLwo+ID4+ICBlbnVtIHsKPiA+PiAgICAgICAgIEdCQVVESU9fREVW
SUNFX05PTkUgICAgICAgICAgICAgICAgICAgICA9IDB4MCwKPiA+PiAgICAgICAgIC8qIHJlc2Vy
dmVkIGJpdHMgKi8KPiA+VGhpcyBsb29rcyBvay4KPiAKPiBEbyBJIG5vdyBuZWVkIHRvIHNlbmQg
djMgd2l0aCB0aGVzZSBleGFjdCBjaGFuZ2VzLCBzaW5jZSBJIG1pc3NlZCB0aGUKPiAnY29tbWl0
IGxvZycgaW4gdGhpcyBvbmU/CgpZZXMgcGxlYXNlLgoKLS0gCnZpcmVzaApfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpncmV5YnVzLWRldiBtYWlsaW5nIGxp
c3QKZ3JleWJ1cy1kZXZAbGlzdHMubGluYXJvLm9yZwpodHRwczovL2xpc3RzLmxpbmFyby5vcmcv
bWFpbG1hbi9saXN0aW5mby9ncmV5YnVzLWRldgo=
